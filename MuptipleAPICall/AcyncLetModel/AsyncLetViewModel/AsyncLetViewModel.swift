//
//  AsyncLetViewModel.swift
//  MuptipleAPICall
//
//  Created by Brij Sundar on 05/05/26.
//
import Combine
import Foundation

class AsyncLetViewModel: ObservableObject {
    @Published var post: [Post] = []
    @Published var comment: [Comments] = []
    @Published var errors: [String] = []
    
    private let apiService: APIServiceProtocol
    init(apiService: APIServiceProtocol = APIService()){
        self.apiService = apiService
    }
    
    // MARK: - Safe Wrapper
    func safeWrapper<T>(_ operation: @escaping () async throws -> T) async -> Result<T, Error>{
        do{
            let value = try await operation()
            return .success(value)
        }catch{
            return .failure(error)
        }
    }
    
    func loadData() async {
        errors.removeAll()
        async let postResult: Result<[Post], Error> = safeWrapper {
            try await self.apiService.fetchPost()
        }
        async let commentResult: Result<[Comments], Error> = safeWrapper {
            try await self.apiService.fetchComment()
        }
        
        let postResponse = await postResult
        let commentResponse = await commentResult
        
        // Handle post
        switch postResponse{
        case .success(let data):
            self.post = data
        case .failure(let error):
            errors.append("Posts API failed: \(error.localizedDescription)")
        }
        
        // Handle comment
        switch commentResponse{
        case .success(let data):
            self.comment = data
        case .failure(let error):
            errors.append("Comments API failed: \(error.localizedDescription)")
        }
        
        // MARK: - Final State Handling
        
        if self.post.isEmpty && self.comment.isEmpty{
            print("No data to display")
        }else if !self.post.isEmpty && !self.comment.isEmpty{
            print("Both API Success")
        }else{
            print("Partial success (one API failed)")
        }
    }
}
