//
//  CombinePipeLineViewModel.swift
//  MuptipleAPICall
//
//  Created by Brij Sundar on 05/05/26.
//
import Foundation
import Combine

class CombinePipeLineViewModel: ObservableObject {
    
    @Published var post: [Post] = []
    @Published var comment: [Comments] = []
    @Published var error: String?
    
    private var cancellables = Set<AnyCancellable>()
    private var api: APIServiceCombineProtocol
    
    init(api: APIServiceCombineProtocol = APIServiceCombine()){
        self.api = api
    }
    // MARK: - Zip
    /*
        if any API fail-- Whole pipline fail
        Same issue as async let
     */
    func loadDataWithZip(){
        api.fetchPosts()
            .zip(api.fetchComments())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    self.error = error.localizedDescription
                }
            } receiveValue: { posts, comments in
                self.post = posts
                self.comment = comments
            }.store(in: &cancellables)
        
    }
    // MARK: - merge
    /*
     Use when APIs are independent
     */
    
    func loadDataWithMerge(){
        let postPublisher = api.fetchPosts()
            .map{"Posts: \($0.count)"}
        let commentPublisher = api.fetchComments()
            .map { "Comments: \($0.count)"}
        
        Publishers.Merge(postPublisher, commentPublisher)
            .sink {
                print($0)
            } receiveValue: {
                print($0)
            }
            .store(in: &cancellables)
    }
    // MARK: - Result

    func loadDataSafe() {
        api.fetchPosts()
            .toResult()
            .zip(api.fetchComments().toResult())
            .receive(on: DispatchQueue.main)
            .sink { result1, result2 in
                
                var errors: [String] = []
                
                // Posts
                switch result1 {
                case .success(let data):
                    self.post = data
                case .failure(let error):
                    errors.append("Posts failed: \(error.localizedDescription)")
                }
                
                // Comments
                switch result2 {
                case .success(let data):
                    self.comment = data
                case .failure(let error):
                    errors.append("Comments failed: \(error.localizedDescription)")
                }
                
                // Final State
                if errors.count == 2 {
                    print("❌ Both failed")
                } else if errors.isEmpty {
                    print("✅ Both success")
                } else {
                    print("⚠️ Partial success")
                }
            }
            .store(in: &cancellables)
    }
}
extension Publisher {
    func toResult() -> AnyPublisher<Result<Output, Failure>, Never> {
        self
            .map { Result.success($0) }
            .catch { Just(Result.failure($0)) }
            .eraseToAnyPublisher()
    }
}
