//
//  Comments.swift
//  MuptipleAPICall
//
//  Created by Brij Sundar on 03/05/26.
//
struct Comments: Decodable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
struct Post: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String

}
