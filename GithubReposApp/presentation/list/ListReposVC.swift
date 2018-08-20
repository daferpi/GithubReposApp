//
//  ListReposVC.swift
//  GithubReposApp
//
//  Created by abelFernandez on 14/08/2018.
//  Copyright © 2018 abelFernandez. All rights reserved.
//

import UIKit

protocol ListReposView {

    var  doListRepoRequest:(() -> ())? { get set }
    func onError(error:ApiError?)
    func onRepoSuccess(repositoryList:[Repository])
}


class ListReposVC: UIViewController {

    var doListRepoRequest:(() -> ())?
    var presenter:ListReposPresenter!

    private var repositoryList:[Repository]!
    private var tableView:UITableView = UITableView()
    private var activityIndicator:UIActivityIndicatorView!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.requestRepos()
    }

    private func setupView() {
        self.repositoryList = [Repository]()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        self.tableView.dataSource = self
        self.view = self.tableView
    }

    private func showErrorMessage(message:String?) {
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        self.present(alert, animated: true)
    }

    private func showActivityIndicator() {
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        self.activityIndicator.center = self.view.center
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.startAnimating()
    }

    private func hiddeActivityIndicator() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.removeFromSuperview()
    }

}

extension ListReposVC:ListReposView {

    func requestRepos() {
        if let doListRepoRequest = self.doListRepoRequest {
            self.showActivityIndicator()
            doListRepoRequest()
        }
    }

    func onError(error: ApiError?) {
        self.hiddeActivityIndicator()
        self.showErrorMessage(message: error?.localizedDescription)
    }

    func onRepoSuccess(repositoryList: [Repository]) {
        self.hiddeActivityIndicator()
        self.repositoryList = repositoryList
        self.tableView.reloadData()
    }


}

extension ListReposVC:UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repositoryList.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewCell(tableView: tableView, reuseIdentifier: "cellId")
        cell.textLabel?.text = self.repositoryList[indexPath.row].full_name
        return cell
    }

    private func tableViewCell(tableView: UITableView, reuseIdentifier: String) -> UITableViewCell {
        if let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) {
            return dequeuedCell
        } else {
            return UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
        }
    }
}
