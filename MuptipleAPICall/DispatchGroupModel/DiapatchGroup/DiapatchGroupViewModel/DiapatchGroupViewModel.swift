//
//  DiapatchGroupViewModel.swift
//  MuptipleAPICall
//
//  Created by Brij Sundar on 03/05/26.
//
import Foundation

class DiapatchGroupViewModel{
    var postResult: [Post] = []
    var comments: [Comments] = []
    var onDataUpdate: (() -> Void)?
    var onError: ((Error) -> Void)?
//    private let apiService: NetworkLayer
    private let apiService: NetworkLayerProtocol
    
    init(apiService: NetworkLayerProtocol) {
        self.apiService = apiService
    }
    
    func fetchData(){
       let dispatchGroup = DispatchGroup()
       var apiError: Error?
        
        dispatchGroup.enter()
        callAsyncPost {
            dispatchGroup.leave()
        } errorHandler: { error in
            apiError = error
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        callAsyncComments {
            dispatchGroup.leave()
        } errorHandler: { error in
            apiError = error
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            if let error = apiError {
                self.onError?(error)
            }else{
                self.onDataUpdate?()
            }
        }
        
    }
    func callAsyncPost(completion: @escaping () -> Void, errorHandler: @escaping ((Error) -> Void)){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        apiService.callAPI(requestUrl: url) { (result: Result<[Post], Error>) in
            switch result {
            case .success(let post):
                self.postResult = post
                completion()
            case .failure(let error):
                errorHandler(error)
            }
        }
    }
    func callAsyncComments(completion: @escaping (() -> Void), errorHandler: @escaping ((Error) -> Void)){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/comments") else { return }
        apiService.callAPI(requestUrl: url) { (result: Result<[Comments], Error>) in
            switch result {
            case .success(let comments):
                self.comments = comments
                completion()
            case .failure(let error):
                errorHandler(error)
            }
        }
    }
    /*
    func callAsyncPost(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        apiService.callAPI(requestUrl: url, completionHandler: { (result: Result<[Post], Error>) in
            switch result {
            case .success(let posts):
                self.postResult = posts
            case .failure(let error):
                print(error)
            }
        })
    }
    func callAsyncComments(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/comments") else { return }
        apiService.callAPI(requestUrl: url) { (result: Result<[Comments], Error>) in
            switch result {
            case .success(let comments):
                self.comments = comments
            case .failure(let error):
                print(error)
            }
        }
    }
    */
}
