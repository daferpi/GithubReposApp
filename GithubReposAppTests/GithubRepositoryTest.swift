//
// Created by abelFernandez on 16/08/2018.
// Copyright (c) 2018 abelFernandez. All rights reserved.
//

import Foundation
import Quick
import Nimble
import OHHTTPStubs

@testable import GithubReposApp

class GithubRepositoryTest:QuickSpec {

    override func spec() {
        var repo:GithubRepository!

        describe("GithubRepository specs") {
            beforeEach {
                repo = GithubRepositoryImpl()
            }

            afterEach {
                OHHTTPStubs.removeAllStubs()
            }
            
            context("when repository is create") {
                it("repository is not null") {
                    expect(repo).toNot(beNil())
                }

                it("check request not fails") {

                    stub(condition:isScheme("https") &&  isHost("api.github.com")) { _ in
                        let stubPath = OHPathForFile("ListRepos.json", type(of: self))
                        return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
                    }

                    waitUntil(timeout: 10) { done in
                        repo.listRepositories { repositories, error in
                            expect(repositories).toNot(beNil())
                            done()
                        }
                    }

                }
            }
        }


    }
}
