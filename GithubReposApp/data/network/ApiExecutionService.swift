//
// Created by abelFernandez on 14/08/2018.
// Copyright (c) 2018 abelFernandez. All rights reserved.
//

import Alamofire

public protocol ApiServiceConfiguration {

    // Base url of the api service
    var baseURL:String { get }

    // the endpoint path
    var path:String { get }

    // the http method to execute by service
    var method:Alamofire.HTTPMethod { get }

    // the headers of the http call
    var headers: [String: String]? { get }

    // the parameters for the call
    var parameters: [String: Any]? { get }

    // the parameter enconding
    var parameterEncoding: ParameterEncoding { get }
}

public class ApiExecutionService<T: ApiServiceConfiguration> {

    typealias Handler = (ApiResult<Any, ApiError>) -> Void

    static func executeCall(apiEndpoint:T, completionHandler:@escaping Handler)  {

        Alamofire
                .request(apiEndpoint.path, method: apiEndpoint.method, parameters: apiEndpoint.parameters, encoding: apiEndpoint.parameterEncoding, headers: apiEndpoint.headers)
                .validate()
                .responseJSON {response in
                    switch response.result {
                    case .success(let data):
                        completionHandler(.success(data))
                    case .failure(let error):
                        completionHandler(.failure(ApiError.invalidCall(message: error.localizedDescription)))
                    }

                }
    }
}
