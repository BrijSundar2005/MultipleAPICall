//
//  MockNetworkLayer.swift
//  MuptipleAPICall
//
//  Created by Brij Sundar on 04/05/26.
//
import Foundation

class MockNetworkLayer: NetworkLayerProtocol{
    var shouldFailPost: Bool = false
    var shouldFailComments: Bool = false
    
    func callAPI<T>(requestUrl: URL, completionHandler: @escaping (Result<T, any Error>) -> Void) where T : Decodable {
        if requestUrl.absoluteString.contains("posts"){
            if shouldFailPost{
                completionHandler(.failure(NSError(domain: "PostError", code: 1)))
                return
            }
            
            let mock = [Post(userId: 1, id: 1, title: "Hello", body: "World")]
            if let typeMock = mock as? T{
                completionHandler(.success(typeMock))
            }else{
                completionHandler(.failure(NSError(domain: "Type missmatch", code: 0)))
            }
        }
        else if requestUrl.absoluteString.contains("comments") {
            
            if shouldFailComments {
                completionHandler(.failure(NSError(domain: "CommentError", code: 2)))
                return
            }
            let mock = [Comments(postId: 1, id: 1, name: "Brij", email: "brij@gmail.com", body: "Test Comment")]
            if let typedMock = mock as? T {
                completionHandler(.success(typedMock))
            } else {
                completionHandler(.failure(NSError(domain: "TypeMismatch", code: 0)))
            }
        }
    }
}
