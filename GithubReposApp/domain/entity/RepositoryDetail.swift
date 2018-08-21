//
// Created by abelFernandez on 21/08/2018.
// Copyright (c) 2018 abelFernandez. All rights reserved.
//

import Foundation

struct RepositoryDetail:Decodable {

    let name:String?
    let full_name:String?
    let owner:RepositoryOwner?
    let description:String?
    let html_url:String?
    let created_at:String?
    let forks_count:Int?
    let open_issues:Int?
    let subscribers_count:Int?
    let watchers_count:Int?
}
