//
//  MuptipleAPICallTests.swift
//  MuptipleAPICallTests
//
//  Created by Brij Sundar on 03/05/26.
//

import XCTest
@testable import MuptipleAPICall

@MainActor
final class DispatchGroupViewModelTests: XCTestCase {
    var viewModel:  DiapatchGroupViewModel?
    var mockAPI: MockNetworkLayer?
    
    override func setUp() {
        super.setUp()
        mockAPI = MockNetworkLayer()
        viewModel = DiapatchGroupViewModel(apiService: mockAPI ?? MockNetworkLayer())
        XCTAssertNotNil(viewModel)
    }
    override func tearDown(){
        mockAPI = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchData_Success(){
        let expectation = XCTestExpectation(description: "Both API Successed")
        
        viewModel?.onDataUpdate = {
            XCTAssertEqual(self.viewModel?.postResult.count, 1)
            XCTAssertEqual(self.viewModel?.comments.count, 1)
            expectation.fulfill()
        }
        viewModel?.onError = { _ in
            XCTFail("Should not call error")
            expectation.fulfill()
        }
        viewModel?.fetchData()
        wait(for: [expectation], timeout: 2)
    }
    
    func testFetchData_Failure(){
        let expectation = XCTestExpectation(description: "Both API Failed")
        
        mockAPI?.shouldFailPost = true
        mockAPI?.shouldFailComments = true
        
        viewModel?.onDataUpdate = {
            XCTFail("Both API Fail")
        }
        
        viewModel?.onError = { error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        viewModel?.fetchData()
        wait(for: [expectation], timeout: 2)
    }
    
    func testFeatchData_PostFailure(){
        let expectation = XCTestExpectation(description: "Post API Failed")
        
        mockAPI?.shouldFailPost = true
        
        viewModel?.onDataUpdate = {
            XCTFail("Post API Fail")
        }
        
        viewModel?.onError = { error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        viewModel?.fetchData()
        wait(for: [expectation], timeout: 2)
    }
    
    func testFeatchData_CommentsFailure(){
        let expectation = XCTestExpectation(description: "Comments API Failed")
        
        mockAPI?.shouldFailComments = true
        
        viewModel?.onDataUpdate = {
            XCTFail("Comments API Fail")
        }
        
        viewModel?.onError = { error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        viewModel?.fetchData()
        wait(for: [expectation], timeout: 2)
    }
}
