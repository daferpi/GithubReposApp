//
// Created by abelFernandez on 20/08/2018.
// Copyright (c) 2018 abelFernandez. All rights reserved.
//

import Foundation

class ListReposPresenter {

    private var view:ListReposView!
    private var interactor:GithubInteractor!

    init(view:ListReposView, interactor:GithubInteractor) {
        self.view = view
        self.interactor = interactor

        self.view.doListRepoRequest = self.interactor.requestListRepo

        self.interactor.onListRepoSuccess = {[weak self] repositoryList in
            self?.view.onRepoSuccess(repositoryList: repositoryList)
        }

        self.interactor.onError = { [weak self] error in
            self?.view.onError(error: error)
        }
    }
}
