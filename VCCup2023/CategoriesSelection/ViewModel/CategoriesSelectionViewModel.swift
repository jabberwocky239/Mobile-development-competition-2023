//
//  CategoriesSelectionViewModel.swift
//  VCCup2023
//
//  Created by Maxım Gaıssın on 17.12.2022.
//

import Foundation
import UIKit

final class CategoriesSelectionViewModel  {
    private var categories: [Category] = Category.allCases
    private(set) var sectionsManager: CategoriesSectionsManager
    
    var selectedCategories: Set<Category> = .init()
    
    init() {
        self.sectionsManager = CategoriesSectionsManager()
    }
    
    //MARK: - INternal methods
    
    func addToSelectedCategory(_ item: Category) {
        selectedCategories.insert(item)
    }
    
    func navigateToNextScreen() {
        print("Переход к следующему экрану")
    }
}
