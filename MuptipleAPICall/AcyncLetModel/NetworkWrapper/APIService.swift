//
//  API Service.swift
//  MuptipleAPICall
//
//  Created by Brij Sundar on 05/05/26.
//
import Foundation

protocol APIServiceProtocol {
    func fetchPost() async throws -> [Post]
    func fetchComment() async throws -> [Comments]
}

class APIService: APIServiceProtocol {
    func fetchPost() async throws -> [Post] {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        let (data, _) = try await URLSession.shared.data(from: url!)
        return try JSONDecoder().decode([Post].self, from: data)
    }
    
    func fetchComment() async throws -> [Comments] {
        let url = URL(string: "https://jsonplaceholder.typicode.com/comments")
        let(data, _) = try await URLSession.shared.data(from: url!)
        return try JSONDecoder().decode([Comments].self, from: data)
    }
}
