//
// Created by abelFernandez on 17/08/2018.
// Copyright (c) 2018 abelFernandez. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import GithubReposApp

enum ResposeResult {
    case success
    case empty
    case error
}


class GithubInteractorTests:QuickSpec {
    
    override func spec() {
        var interactor:GithubInteractor!
        
        describe("test interactor") {
            beforeEach {
                interactor = GithubInteractorImpl(repository: MockupRepo(responseResult: .success))
            }
            
            context("when interactor is create") {
                it("interactor is not null") {
                    expect(interactor).toNot(beNil())
                }
            }
            
            context("when request list method is called") {

                it("request return a valid list list") {
                    interactor.onListRepoSuccess = {repositories in
                        expect(repositories).toNot(beNil())
                        expect(repositories.count).to(equal(2))
                    }
                    interactor.requestListRepo()
                }

                it("request return a valid list list") {
                    interactor = GithubInteractorImpl(repository: MockupRepo(responseResult: .empty))
                    interactor.onListRepoSuccess = {repositories in
                        expect(repositories).toNot(beNil())
                        expect(repositories.isEmpty).to(beTrue())
                    }
                    interactor.requestListRepo()

                }

                it("request return error") {
                    interactor = GithubInteractorImpl(repository: MockupRepo(responseResult: .error))
                    interactor.onError = {error in
                        expect(error).toNot(beNil())
                    }
                    interactor.requestListRepo()

                }
            }
        }
        
    }
}

class MockupRepo: GithubRepository {
    private let result:ResposeResult
    
    init(responseResult:ResposeResult) {
        self.result = responseResult
    }
    
    func listRepositories(completionHandler: @escaping CompletionHandlerList ) {
        switch result {
        case .success:
            let repositories = self.createRepositories()
            completionHandler(repositories, nil)
        case .error:
            completionHandler(nil, ApiError.invalidCall(message: "error"))
        case .empty:
            completionHandler([], nil)
        }
        
    }
    func detailRepository(owner:String, repoName:String, completionHandler: @escaping CompletionHandlerUnit) {
        switch result {
        case .success:
            let repository = self.createRepository(index: 1)
            completionHandler(repository, nil)
        case .error:
            completionHandler(nil, ApiError.invalidCall(message: "error"))
        case .empty:
            completionHandler(nil, nil)
        }
    }
    
    private func createRepositories() -> [Repository] {
        
        let repository1 = self.createRepository(index: 1)
        
        let repository2 = self.createRepository(index: 2)
        
        return [repository1, repository2]
    }
    
    private func createRepository(index:Int) -> Repository {
        let repositoryOwner = RepositoryOwner(login: "owner\(index)", id: index, avatar_url: "http://avatarUrl\(index).com", url: "http://Url\(index).com")
        let repository = Repository(id: index, name: "repository\(index)", full_name: "repositoryFullName\(index)", owner: repositoryOwner, url: "http://url\(index)", description: "description\(index)")
        return repository
    }
}
