//
// Created by abelFernandez on 17/08/2018.
// Copyright (c) 2018 abelFernandez. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import GithubReposApp

class GithubInteractorTests:QuickSpec {
    
    override func spec() {
        var interactor:GithubInteractor!
        
        describe("test interactor") {
            beforeEach {
                interactor = GithubInteractorImpl()
            }
            
            context("when interactor is create") {
                it("interactor is not null") {
                    expect(interactor).toNot(beNil())
                }
            }
        }
        
    }
}
