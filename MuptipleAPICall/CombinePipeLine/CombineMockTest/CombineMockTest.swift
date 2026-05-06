//
//  CombineMockTest.swift
//  MuptipleAPICall
//
//  Created by Brij Sundar on 05/05/26.
//
import Combine
import Foundation

class CombineMockTest: APIServiceCombineProtocol{
    var shouldPostFailure: Bool = false
    var shouldCommentFailure: Bool = false
    
    func fetchPosts() -> AnyPublisher<[Post], any Error> {
        if self.shouldPostFailure {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        }else{
            return Just([Post(userId: 1, id: 1, title: "Hello", body: "world")])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
    func fetchComments() -> AnyPublisher<[Comments], any Error> {
        if shouldCommentFailure {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        }else{
            return Just([Comments(postId: 1, id: 1, name: "Brij", email: "brij@gmail.com", body: "Hello World")])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}

