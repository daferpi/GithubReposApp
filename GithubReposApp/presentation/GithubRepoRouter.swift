//
// Created by abelFernandez on 21/08/2018.
// Copyright (c) 2018 abelFernandez. All rights reserved.
//

import UIKit

class GithubRepoRouter:Router {

    enum Destination {
        case listRepos
        case detailRepos(owner:String, repoName:String)
    }

    private weak var navigationController:UINavigationController?

    init(navigationController:UINavigationController) {
        self.navigationController = navigationController
    }

    func route(to destination: Destination) {
        let viewController = createViewController(for: destination)
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    private func createViewController(for destination:Destination) -> UIViewController {
        switch destination {
        case .listRepos:
            return ViewFactory.createListRepoView()
        case .detailRepos(let owner, let repoName):
            return ViewFactory.createDetailRepoView(owner: owner, repoName: repoName)
        }
        
    }
}
