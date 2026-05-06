//
//  APIServiceCombineProtocol.swift
//  MuptipleAPICall
//
//  Created by Brij Sundar on 05/05/26.
//
import Combine
import Foundation

protocol APIServiceCombineProtocol{
    func fetchPosts() -> AnyPublisher<[Post], Error>
    func fetchComments() -> AnyPublisher<[Comments], Error>
}

class APIServiceCombine: APIServiceCombineProtocol {
    func fetchPosts() -> AnyPublisher<[Post], any Error> {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map {$0.data}
            .decode(type: [Post].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func fetchComments() -> AnyPublisher<[Comments], any Error> {
        let url = URL(string: "https://jsonplaceholder.typicode.com/comments")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Comments].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

