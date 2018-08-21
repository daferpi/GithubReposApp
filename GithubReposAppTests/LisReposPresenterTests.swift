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
        let view = MockupListRepoView()
        let interactor = MockupGithubInteractor()

        describe("Presenter test") {

            beforeEach {
                presenter = ListReposPresenter(view: view, interactor: interactor)
            }

            context("When presenter is create") {
                it("Presenter is not null") {
                    expect(presenter).toNot(beNil())
                }

                it("View methods is not null") {
                    expect(view.doListRepoRequest).toNot(beNil())
                }

                it("Interactor methods is not null") {
                    expect(interactor.onListRepoSuccess).toNot(beNil())
                    expect(interactor.onError).toNot(beNil())
                }

                it("When call interactor onListRepoSuccess methods view methods is called") {
                    let view = MockupListRepoView()
                    let interactor = MockupGithubInteractor()

                    presenter = ListReposPresenter(view: view, interactor: interactor)

                    view.requestRepos()

                    expect(view.successIsCalled).to(beTrue())
                }
            }
        }



    }
}

class MockupListRepoView:ListReposView {

    var doListRepoRequest: (() -> ())?

    var errorIsCalled:Bool = false
    var successIsCalled:Bool = false

    func onError(error: ApiError?) {
        self.errorIsCalled = true
    }

    func onRepoSuccess(repositoryList: [Repository]) {
        self.successIsCalled = true
    }

    func requestRepos() {
        if let doListRepoRequest = self.doListRepoRequest {
            doListRepoRequest()
        }
    }
}

class MockupGithubInteractor:GithubInteractor {

    var onListRepoSuccess: (([Repository]) -> ())?
    var onError: ((ApiError?) -> ())?
    var onDetailRepoSuccess: ((RepositoryDetail) -> ())?

    private var requestListCalled:Bool = false
    private var requestDetailRepoCalled:Bool = false

    func requestListRepo() {
        self.requestListCalled = true

        if let onListRepoSuccess = self.onListRepoSuccess {
            onListRepoSuccess([Repository]())
        }
    }


    func requestDetailRepo(owner: String, repoName: String) {
        self.requestDetailRepoCalled = true
     }

}
