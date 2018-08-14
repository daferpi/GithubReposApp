//
// Created by abelFernandez on 14/08/2018.
// Copyright (c) 2018 abelFernandez. All rights reserved.
//

import Alamofire

enum GithubApi {
    case listRepos
    case detailRepo(owner:String, repositoryName:String)
}

extension GithubApi:ApiServiceConfiguration {
    var baseURL: String {
        return ApiConstants.gitHubBaseUrl
    }

    var path: String {
        switch self {
        case .listRepos:
            return baseURL + "/repositories"
        case .detailRepo(let owner, let repositoryName):
            return baseURL + "/repos/\(owner)/\(repositoryName)"
        }
    }


    var method: Alamofire.HTTPMethod {
        switch self {
        case .listRepos, .detailRepo(_, _):
            return .get
        }
    }

    var headers: [String: String]? {
        return nil
    }

    var parameters: [String: Any]? {
        return nil
    }

    var parameterEncoding: Alamofire.ParameterEncoding {

        return URLEncoding.default
    }
}
