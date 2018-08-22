//
//  DetailsRepoVC.swift
//  GithubReposApp
//
//  Created by abelFernandez on 21/08/2018.
//  Copyright © 2018 abelFernandez. All rights reserved.
//

import UIKit

protocol DetailsRepoView {
    var owner:String {get set}
    var repoName:String {get set}
    var doDetailsRepo:((_ owner:String,  _ repoName:String) -> ())? { get set }
    func onError(error:ApiError?)
    func onDetailsSuccess(repository:RepositoryDetail)
}

class DetailsRepoVC: UIViewController {
    
    @IBOutlet weak var labelRepoName: UILabel!
    @IBOutlet weak var labelOwner: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelCreatAtTitle: UILabel!
    @IBOutlet weak var labelCreateAtValue: UILabel!
    @IBOutlet weak var labelSubscribersTitle: UILabel!
    @IBOutlet weak var labelSubscribersValue: UILabel!
    @IBOutlet weak var labelForkCountTitle: UILabel!
    @IBOutlet weak var labelForkCountValue: UILabel!
    @IBOutlet weak var labelOpenIssuesTitle: UILabel!
    @IBOutlet weak var labelOpenIssuesValue: UILabel!
    @IBOutlet weak var webViewRepo: UIWebView!
    

    var owner:String
    var repoName:String
    var doDetailsRepo: ((String, String) -> ())?
    var presenter:DetailsRepoPresenter!
    private var activityIndicator:UIActivityIndicatorView!

    init(owner:String, repoName:String) {
        self.owner = owner
        self.repoName = repoName
        super.init(nibName: "DetailsRepoVC", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.requestDetails()
    }

    private func setupView() {
        labelRepoName.text = ""
        labelOwner.text = ""
        labelDescription.text = ""
        labelCreatAtTitle.text = "Create At: "
        labelCreateAtValue.text = ""
        labelSubscribersTitle.text = "Subscribers: "
        labelSubscribersValue.text = ""
        labelForkCountTitle.text = "Forks Count: "
        labelForkCountValue.text = ""
        labelOpenIssuesTitle.text = "Forks Count: "
        labelOpenIssuesValue.text = ""
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

extension DetailsRepoVC:DetailsRepoView {

    func requestDetails() {
        self.showActivityIndicator()
        if let doDetailsRepo = self.doDetailsRepo {
            doDetailsRepo(self.owner, self.repoName)
        }

    }

    func onDetailsSuccess(repository: RepositoryDetail) {
        self.hiddeActivityIndicator()
        updateView(repository: repository)
    }

    private func updateView(repository: RepositoryDetail) {
        labelRepoName.text = repository.full_name ?? ""
        labelOwner.text = repository.owner?.login ?? ""
        labelDescription.text = repository.description ?? ""
        labelCreateAtValue.text = repository.created_at ?? ""
        labelSubscribersValue.text = "\(repository.subscribers_count ?? 0)"
        labelForkCountValue.text = "\(repository.forks_count ?? 0)"
        labelOpenIssuesValue.text = "\(repository.open_issues ?? 0)"

        if let htmlUrl = repository.html_url, let URL = URL(string: htmlUrl) {
            self.webViewRepo.loadRequest(URLRequest(url: URL))
        }
    }

    func onError(error: ApiError?) {
        self.showErrorMessage(message: error?.localizedDescription)
    }
}
