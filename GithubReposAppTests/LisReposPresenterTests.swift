//
// Created by abelFernandez on 20/08/2018.
// Copyright (c) 2018 abelFernandez. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import GithubReposApp


class LisReposPresenterTests:QuickSpec {

    override func spec() {
        var presenter:ListReposPresenter!

        describe("Presenter test") {

            beforeEach {
                let view = MockupListRepoView()
                let interactor = MockupGithubInteractor()
                presenter = ListReposPresenter(view: view, interactor: interactor)
            }

            context("When presenter is create") {
                it("Presenter is not null") {
                    expect(presenter).toNot(beNil())
                }
            }
        }



    }
}

class MockupListRepoView:ListReposView {

    var doListRepoRequest: (() -> ())?

    private var errorIsCalled:Bool = false
    private var successIsCalled:Bool = false

    func onError(error: ApiError?) {
        self.errorIsCalled = true
    }

    func onRepoSuccess(repositoryList: [Repository]) {
        self.successIsCalled = true
    }
}

class MockupGithubInteractor:GithubInteractor {

    var onListRepoSuccess: (([Repository]) -> ())? = nil
    var onError: ((ApiError?) -> ())? = nil
    var onDetailRepoSuccess: ((Repository) -> ())? = nil

    private var requestListCalled:Bool = false
    private var requestDetailRepoCalled:Bool = false

    func requestListRepo() {
        self.requestListCalled = true
    }


    func requestDetailRepo(owner: String, repoName: String) {
        self.requestDetailRepoCalled = true
     }

}
