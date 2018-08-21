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
    func onDetailsSuccess(repository:Repository)
}

class DetailsRepoVC: UIViewController {

    var owner:String!
    var repoName:String!
    var doDetailsRepo: ((String, String) -> ())?
    var presenter:DetailsRepoPresenter!

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
    }

}

extension DetailsRepoVC:DetailsRepoView {

    func onDetailsSuccess(repository: Repository) {
    }

    func onError(error: ApiError?) {
    }
}
