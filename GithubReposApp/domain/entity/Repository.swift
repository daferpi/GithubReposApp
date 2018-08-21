//
// Created by abelFernandez on 14/08/2018.
// Copyright (c) 2018 abelFernandez. All rights reserved.
//

import Foundation

struct Repository:Decodable {

    let id:Int?
    let name:String?
    let full_name:String?
    let owner:RepositoryOwner?
    let description:String?
}
