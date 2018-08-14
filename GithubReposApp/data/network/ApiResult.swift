//
// Created by abelFernandez on 14/08/2018.
// Copyright (c) 2018 abelFernandez. All rights reserved.
//

import Foundation

enum ApiResult<Value, Error:Swift.Error> {
    case success(Value)
    case failure(Error)
}

extension ApiResult {
    func resolve() throws -> Value {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
}

extension ApiResult where Value == Data {
    func decode<T:Decodable>() throws -> T {
        let decoder = JSONDecoder()
        let data = try resolve()
        return try decoder.decode(T.self, from: data)
    }
}