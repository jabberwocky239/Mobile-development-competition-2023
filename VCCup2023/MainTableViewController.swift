//
//  MainTableViewController.swift
//  VCCup2023
//
//  Created by Maxım Gaıssın on 17.12.2022.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    private let controllers = ["categories"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            showCategoriesSelection()
        default:
            break
        }
    }
    
    private func showCategoriesSelection() {
        let viewModel = CategoriesSelectionViewModel()
        let controller = CategoriesSelectionController(viewModel: viewModel)
        
        navigationController?.pushViewController(controller, animated: true)
    }
}

