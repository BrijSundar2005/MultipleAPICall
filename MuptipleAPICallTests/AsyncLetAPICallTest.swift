//
//  AsyncLetAPICallTest.swift
//  MuptipleAPICall
//
//  Created by Brij Sundar on 05/05/26.
//
import XCTest
@testable import MuptipleAPICall

@MainActor
final class AsyncLetAPICallTest: XCTestCase {
    func testBothAPI_Success() async{
        
        let mock = MockAPIService()
        let viewModel = AsyncLetViewModel(apiService: mock)
        mock.shouldFailPostAPI = false
        mock.shouldFaileCommentAPI = false
       
        await viewModel.loadData()
        XCTAssertFalse(viewModel.post.isEmpty)
        XCTAssertFalse(viewModel.comment.isEmpty)
        XCTAssertEqual(viewModel.errors.count, 0)
        
    }
    func testPartialAPIFail_PostFailure() async{
        let mock = MockAPIService()
        mock.shouldFailPostAPI = true
        let viewModel = AsyncLetViewModel(apiService: mock)
        
        await viewModel.loadData()
        XCTAssertTrue(viewModel.post.isEmpty)
        XCTAssertFalse(viewModel.comment.isEmpty)
        XCTAssertEqual(viewModel.errors.count, 1)
        
    }
    func testPartialAPIFail_CommentFailure() async{
        let mock = MockAPIService()
        mock.shouldFaileCommentAPI = true
        let viewModel = AsyncLetViewModel(apiService: mock)
        
        await viewModel.loadData()
        XCTAssertFalse(viewModel.post.isEmpty)
        XCTAssertTrue(viewModel.comment.isEmpty)
        XCTAssertEqual(viewModel.errors.count, 1)
    }
    
    func testBothFail() async {
        let mock = MockAPIService()
        mock.shouldFailPostAPI = true
        mock.shouldFaileCommentAPI = true
        
        let viewModel = AsyncLetViewModel(apiService: mock)
        
        await viewModel.loadData()
        
        XCTAssertTrue(viewModel.post.isEmpty)
        XCTAssertTrue(viewModel.comment.isEmpty)
        XCTAssertEqual(viewModel.errors.count, 2)
    }
}

