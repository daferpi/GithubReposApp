//
// Created by abelFernandez on 21/08/2018.
// Copyright (c) 2018 abelFernandez. All rights reserved.
//

import Foundation

class DetailsRepoPresenter {

    private var view:DetailsRepoView!
    private var interactor:GithubInteractor!

    init(view:DetailsRepoView, interactor:GithubInteractor) {
        self.view = view
        self.interactor = interactor

        self.interactor.onDetailRepoSuccess = { [weak self] repository in
            self?.view.onDetailsSuccess(repository: repository)
        }

        self.interactor.onError = { [weak self] error in
            self?.view.onError(error: error)
        }

        self.view.doDetailsRepo = self.interactor.requestDetailRepo
    }
}
