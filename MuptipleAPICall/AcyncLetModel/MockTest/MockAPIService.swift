//
//  MockAPIService.swift
//  MuptipleAPICall
//
//  Created by Brij Sundar on 05/05/26.
//

import Foundation

class MockAPIService: APIServiceProtocol {
    var shouldFailPostAPI: Bool = false
    var shouldFaileCommentAPI: Bool = false
    
    func fetchPost() async throws -> [Post] {
        if shouldFailPostAPI {
            throw URLError(.badServerResponse)
        }
        return [Post(userId: 1, id: 1, title: "Hello", body: "World")]
    }
    
    func fetchComment() async throws -> [Comments] {
        if shouldFaileCommentAPI{
          throw URLError(.badServerResponse)
        }
        return [Comments(postId: 1, id: 1, name: "Brij", email: "brij@gmail.com", body: "Test")]
    }
}
