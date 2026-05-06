//
//  CombineViewController.swift
//  MuptipleAPICall
//
//  Created by Brij Sundar on 05/05/26.
//
import UIKit
import Combine

class CombineViewController: UIViewController {
    private let viewModel = CombinePipeLineViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bindViewModel()
        viewModel.loadDataWithZip()
    }
    func bindViewModel(){
        viewModel.$post
            .receive(on: DispatchQueue.main)
            .sink { [weak self] post in
                print("Posts count:", post.count)
            }.store(in: &cancellables)
        
        viewModel.$comment
            .receive(on: DispatchQueue.main)
            .sink { [weak self] comment in
                print("Comment count:", comment.count)
            }.store(in: &cancellables)
    }
}
