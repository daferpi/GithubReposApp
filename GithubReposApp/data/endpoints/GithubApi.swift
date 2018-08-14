//
// Created by abelFernandez on 14/08/2018.
// Copyright (c) 2018 abelFernandez. All rights reserved.
//

import Alamofire

enum GithubApi {
    case listRepos
    case detailRepo(repoId:String)
}

extension GithubApi:ApiServiceConfiguration {
    var baseURL: String {
        return ApiConstants.gitHubBaseUrl
    }

    var path: String {
        switch self {
        case .listRepos:
            return baseURL + "/repositories"
        case .detailRepo(let repoId):
            return baseURL + "/repos/" + repoId
        }
    }


    var method: Alamofire.HTTPMethod {
        switch self {
        case .listRepos:
            return .get
        case .detailRepo(let repoId):
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
