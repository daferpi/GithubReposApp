//
// Created by abelFernandez on 14/08/2018.
// Copyright (c) 2018 abelFernandez. All rights reserved.
//

import Foundation

protocol GithubRepository {

    func listRepositories() -> [Repository]
    func detailRepository(owner:String, repoName:String) -> Repository

}

extension GithubRepository {
    static func create(apiClient:ApiExecutionService<GithubApi> = ApiExecutionService<GithubApi>()) -> GithubRepository {
        return GithubRepositoryImpl(apiClient: apiClient)
    }
}


private class GithubRepositoryImpl:GithubRepository {

    private let apiClient:ApiExecutionService<GithubApi>

    init(apiClient:ApiExecutionService<GithubApi> = ApiExecutionService<GithubApi>()) {
        self.apiClient = apiClient
    }

    func listRepositories() -> [Repository] {
        fatalError("listRepositories() has not been implemented")
    }

    func detailRepository(owner: String, repoName: String) -> Repository {
        fatalError("detailRepository(owner:repoName:) has not been implemented")
    }

}