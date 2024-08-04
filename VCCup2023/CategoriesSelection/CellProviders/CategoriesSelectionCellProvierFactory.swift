//
//  CategoriesSelectionCellProvierFactory.swift
//  VCCup2023
//
//  Created by Maxım Gaıssın on 18.12.2022.
//

import UIKit

struct CategoriesSelectionCellProvierFactory: CellProviderFactory {
    
    private weak var controller: CategoriesSelectionController?
    
    init(controller: CategoriesSelectionController) {
        self.controller = controller
    }
    
    func make(_ collectionView: UICollectionView) -> Provider<CategorySelectionSection.Item> {
        registerCells(collectionView)
        return { (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let controller = controller else {
                return nil
            }
            
            switch item.type {
            case .categories(let category):
                let cell = collectionView.dequeueCell(CategorySelectionCell.self, for: indexPath)
                cell.categoryDescription = category.description
                return cell
                
            case .selectCategoriesLaterItem:
                let cell = collectionView.dequeueCell(SelectCategoriesLaterCell.self, for: indexPath)
                cell.delegate = controller
                return cell
                
            }
        }
    }
    
    func registerCells(_ collectionView: UICollectionView) {
        collectionView.register(SelectCategoriesLaterCell.self)
        collectionView.register(CategorySelectionCell.self)
    }
}
