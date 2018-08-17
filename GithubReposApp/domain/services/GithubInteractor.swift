//
// Created by abelFernandez on 17/08/2018.
// Copyright (c) 2018 abelFernandez. All rights reserved.
//

import Foundation

protocol GithubInteractor {

    // list repo methods
    func requestListRepo()
    var onListRepoSuccess:(([Repository]) -> ())? { get set }
    var onError:((ApiError?) -> ())? { get set }

    // detail repo methods
    func requestDetailRepo(owner:String, repoName:String)
    var onDetailRepoSuccess:((Repository) -> ())? { get set}
}

class GithubInteractorImpl:GithubInteractor {

    private var repository:GithubRepository!

    public var onListRepoSuccess:(([Repository]) -> ())?
    public var onDetailRepoSuccess:((Repository) -> ())?
    public var onError:((ApiError?) -> ())?

    init(repository:GithubRepository = GithubRepositoryImpl()) {
        self.repository = repository
    }

    func requestListRepo() {
        repository.listRepositories { [weak self] repositories, error in
            guard let repositories = repositories else {
                self?.onRequestFails(error: error)
                return
            }

            if let onListRepoSuccess = self?.onListRepoSuccess {
                onListRepoSuccess(repositories)
            }
        }
    }

    private func onRequestFails(error: ApiError?) {
        if let onError = self.onError {
            onError(error)
        }
    }

    func requestDetailRepo(owner: String, repoName: String) {
        repository.detailRepository(owner: owner, repoName: repoName) { [weak self] repository, error in

            guard let repository = repository else {
                self?.onRequestFails(error: error)
                return
            }

            if let onDetailRepoSuccess = self?.onDetailRepoSuccess {
                onDetailRepoSuccess(repository)
            }

        }
    }
}
