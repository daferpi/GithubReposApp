//
// Created by abelFernandez on 14/08/2018.
// Copyright (c) 2018 abelFernandez. All rights reserved.
//

import Foundation

protocol GithubRepository {

    typealias CompletionHandlerList =  ([Repository]?, ApiError?) -> ()
    typealias CompletionHandlerUnit =  (RepositoryDetail?, ApiError?) -> ()
    func listRepositories(completionHandler: @escaping CompletionHandlerList )
    func detailRepository(owner:String, repoName:String, completionHandler: @escaping CompletionHandlerUnit)

}

public class GithubRepositoryImpl:GithubRepository {

    private let apiClient:ApiExecutionService<GithubApi>

    init(apiClient:ApiExecutionService<GithubApi> = ApiExecutionService<GithubApi>()) {
        self.apiClient = apiClient
    }

    func listRepositories(completionHandler: @escaping CompletionHandlerList ) {
        apiClient.executeCall(apiEndpoint: .listRepos) { apiResult in
            do {
                switch apiResult {
                case .success(_):
                    let repositories = try apiResult.decode() as [Repository]
                    completionHandler(repositories, nil)
                case .failure(let apiError):
                    completionHandler(nil, apiError)
                }
            } catch {
                completionHandler(nil, ApiError.invalidCall(message: "Error obtaining data"))
            }
        }
    }

    func detailRepository(owner:String, repoName:String, completionHandler: @escaping CompletionHandlerUnit) {
        apiClient.executeCall(apiEndpoint: .detailRepo(owner: owner, repositoryName: repoName)) { (apiResult: ApiResult<Data, ApiError>) in

            do {
                switch apiResult {
                case .success(_):
                    let repository = try apiResult.decode() as RepositoryDetail
                    completionHandler(repository, nil)
                case .failure(let apiError):
                    completionHandler(nil, apiError)
                }
            } catch {
                completionHandler(nil, ApiError.invalidCall(message: "Error obtaining data"))
            }
        }
    }

}