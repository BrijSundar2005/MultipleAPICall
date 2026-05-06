//
//  AsyncLetViewController.swift
//  MuptipleAPICall
//
//  Created by Brij Sundar on 05/05/26.
//
import UIKit

class AsyncLetViewController: UIViewController{
    
    let viewModel = AsyncLetViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        Task{
            await viewModel.loadData()
        }
    }
}
