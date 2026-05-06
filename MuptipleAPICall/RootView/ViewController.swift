//
//  ViewController.swift
//  MuptipleAPICall
//
//  Created by Brij Sundar on 03/05/26.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var rootTableView: UITableView!
    let dataArray: [String] = ["Dispatch Group", "Async/Await", "Combine"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RootTableCell")
        cell?.textLabel?.text = dataArray[indexPath.row]
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let apiService = NetworkLayer()
            let viewModel = DiapatchGroupViewModel(apiService: apiService)
                  
            let vc = DispatchGroupViewController(viewModel: viewModel)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 1{
            
            let vc = AsyncLetViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 2{
            let vc = CombineViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

