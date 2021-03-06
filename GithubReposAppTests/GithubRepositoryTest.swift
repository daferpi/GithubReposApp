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
        let owner = "octocat"
        let repoName = "Hello-World"

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
            }

            context("when repository calls list repository method") {

                it("check request not fails") {

                    stub(condition:isScheme("https") &&  isHost("api.github.com")) { _ in
                        let stubPath = OHPathForFile("ListRepos.json", type(of: self))
                        return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
                    }

                    waitUntil(timeout: 10) { done in
                        repo.listRepositories { repositories, error in
                            expect(repositories).toNot(beNil())
                            expect(repositories).toNot(beEmpty())
                            expect(error).to(beNil())
                            done()
                        }
                    }

                }

                it("check request when received bad json response") {

                    stub(condition:isScheme("https") &&  isHost("api.github.com")) { _ in
                        let stubPath = OHPathForFile("ListReposError.json", type(of: self))
                        return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
                    }

                    waitUntil(timeout: 10) { done in
                        repo.listRepositories { repositories, error in
                            expect(repositories).to(beNil())
                            expect(error).toNot(beNil())
                            done()
                        }
                    }

                }


                it("check that when the API not have connection send error") {
                    stub(condition:isScheme("https") &&  isHost("api.github.com")) { _ in
                        let notConnectedError = NSError(domain: NSURLErrorDomain, code: URLError.notConnectedToInternet.rawValue)
                        return OHHTTPStubsResponse(error:notConnectedError)
                    }

                    waitUntil(timeout: 10) { done in
                        repo.listRepositories { repositories, error in
                            expect(repositories).to(beNil())
                            expect(error).toNot(beNil())
                            done()
                        }
                    }

                }
            }

            context("When repository calls detail repo method") {

                it("check request not fails") {

                    stub(condition:isScheme("https") &&  isHost("api.github.com")) { _ in
                        let stubPath = OHPathForFile("DetailRepo.json", type(of: self))
                        return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
                    }

                    waitUntil(timeout: 10) { done in
                        repo.detailRepository(owner: owner, repoName: repoName) { repository, error in
                            expect(repository).toNot(beNil())
                            expect(repository?.owner?.login).to(equal(owner))
                            expect(repository?.name).to(equal(repoName))
                            expect(error).to(beNil())
                            done()
                        }

                    }

                }

                it("check reponse send error when json is wrong") {

                    stub(condition:isScheme("https") &&  isHost("api.github.com")) { _ in
                        let stubPath = OHPathForFile("DetailRepoError.json", type(of: self))
                        return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
                    }

                    waitUntil(timeout: 10) { done in
                        repo.detailRepository(owner: owner, repoName: repoName) { repository, error in
                            expect(repository).to(beNil())
                            expect(error).toNot(beNil())
                            done()
                        }

                    }
                }

                it("check reponse send error when connetion fails") {

                    stub(condition:isScheme("https") &&  isHost("api.github.com")) { _ in
                        let notConnectedError = NSError(domain: NSURLErrorDomain, code: URLError.notConnectedToInternet.rawValue)
                        return OHHTTPStubsResponse(error:notConnectedError)
                    }

                    waitUntil(timeout: 10) { done in
                        repo.detailRepository(owner: owner, repoName: repoName) { repository, error in
                            expect(repository).to(beNil())
                            expect(error).toNot(beNil())
                            done()
                        }

                    }

                }



            }
        }


    }
}
