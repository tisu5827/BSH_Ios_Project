//
//  ProjectTests.swift
//  ProjectTests
//
//  Created by mac033 on 6/12/24.
//

import XCTest
@testable import Project

final class ProjectTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testCatCrawling(){
        
        let expection = XCTestExpectation(description: "Cat Crawling")
        
        let service = approach()
        service.getImages(page: 0, limit: 0) { result in
            switch result {
            case .failure(let error):
                expection.fulfill()
            case .success(let response):
                print(response)
                expection.fulfill()
            }
        }
        
        wait(for: [expection], timeout: 10.0)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
