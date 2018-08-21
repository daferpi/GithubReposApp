//
// Created by abelFernandez on 21/08/2018.
// Copyright (c) 2018 abelFernandez. All rights reserved.
//

import Foundation

protocol Router {

    associatedtype Destination

    func route(to destination:Destination)
}
