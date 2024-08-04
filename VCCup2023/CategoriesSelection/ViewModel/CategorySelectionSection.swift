//
//  CategoriesSelectionSection.swift
//  VCCup2023
//
//  Created by Maxım Gaıssın on 18.12.2022.
//

import UIKit

struct CategorySelectionSection: CompositionalLayoutSection {
    static func == (lhs: CategorySelectionSection,
                    rhs: CategorySelectionSection) -> Bool {
        lhs.type == rhs.type
    }

    enum SectionType: CaseIterable {
        case selectCategoriesLater
        case categories
    }
    
    struct Item: Hashable {
        static func == (lhs: Item, rhs: Item) -> Bool {
            return lhs.id == rhs.id
        }
        
        enum ItemType {
            case selectCategoriesLaterItem
            case categories(Category)
        }
        
        let type: ItemType
        let id = UUID()
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
    }
   
    let type: SectionType
    let items: [Item]
    
    let groupInterItemSpacing: NSCollectionLayoutSpacing?
    let hasFooter: Bool
    let hasHeader: Bool
    let groupIsHorizontal: Bool
    let inset: NSDirectionalEdgeInsets
    let title: String?
    
    func groupLenght() -> CompositionalLayoutGroupLenght {
        .max
    }

    func groupSize(in environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSize {
        switch type {
        case .selectCategoriesLater:
            return .init(widthDimension: .fractionalWidth(1),
                         heightDimension: .absolute(60))
        case .categories:
            return .init(widthDimension: .fractionalWidth(1),
                         heightDimension: .estimated(300))
        }
    }
    
    func layoutItem() -> NSCollectionLayoutItem  {
        switch type {
        case .selectCategoriesLater:
            return .init(width: .fractionalWidth(1), height: .fractionalHeight(1))
        case .categories:
            return .init(width: .estimated(86), height: .absolute(40))
        }
    }
    
    func layoutItemInsets() -> NSDirectionalEdgeInsets {
        return .init(top: 2, leading: 2, bottom: 2, trailing: 2)
    }
    
    func orthogonalScroll() -> UICollectionLayoutSectionOrthogonalScrollingBehavior {
        .none
    }
}

