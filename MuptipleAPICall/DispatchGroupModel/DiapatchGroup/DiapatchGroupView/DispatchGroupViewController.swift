//
//  DispatchGroupViewController.swift
//  MuptipleAPICall
//
//  Created by Brij Sundar on 03/05/26.
//

import UIKit

class DispatchGroupViewController: UIViewController {
    
    let viewModel: DiapatchGroupViewModel
    init(viewModel: DiapatchGroupViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.fetchData()
        updateUI()
    }
    private func updateUI(){
        viewModel.onDataUpdate = { [weak self] in
            print("Post: \(self?.viewModel.postResult[0].title ?? "")")
            print("Comments: \(self?.viewModel.comments[0].email ?? "")")
        }
    }
}
