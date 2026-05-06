//
//  CombineAPICallTest.swift
//  MuptipleAPICall
//
//  Created by Brij Sundar on 05/05/26.
//
import XCTest
import Combine

@testable import MuptipleAPICall

class CombineAPICallTest: XCTestCase {
    var cancellables: Set<AnyCancellable> = []
    
    func testLoadPostsSuccess() {
        let mock = CombineMockTest()
        let viewModel = CombinePipeLineViewModel()
        
        let expectation = XCTestExpectation(description: "Posts loaded")
        
        viewModel.$post
            .dropFirst() // ignore initial empty value
            .sink { posts in
                XCTAssertEqual(posts.count, 1)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        viewModel.loadDataWithZip()
        wait(for: [expectation], timeout: 2)
    }
    func testLoadPostsFailure() {
        let mock = CombineMockTest()
        mock.shouldPostFailure = true
        
        let viewModel = CombinePipeLineViewModel()
        
        let expectation = XCTestExpectation(description: "Error received")
        
        viewModel.$error
            .dropFirst()
            .sink { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.loadDataWithZip()
        
        wait(for: [expectation], timeout: 2)
    }
}

