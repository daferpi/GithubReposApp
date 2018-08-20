//
// Created by abelFernandez on 20/08/2018.
// Copyright (c) 2018 abelFernandez. All rights reserved.
//

import UIKit

class ViewFactory {

    static func createListRepoView() -> UIViewController {
        let interactor:GithubInteractor = GithubInteractorImpl()
        let view = ListReposVC(nibName: "ListReposVC", bundle: nil)
        view.presenter = ListReposPresenter(view: view, interactor: interactor)
        return view
    }
}
