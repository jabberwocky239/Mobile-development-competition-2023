//
//  CompositionalLayoutSection.swift
//  VCCup2023
//
//  Created by Maxım Gaıssın on 18.12.2022.
//

import UIKit

protocol CompositionalLayoutSection: Hashable {
    
    associatedtype SectionType: Hashable
    associatedtype Item: Hashable
    
    var type: SectionType { get }
    var items: [Item] { get }
    
    var groupInterItemSpacing: NSCollectionLayoutSpacing? { get }
    var hasFooter: Bool { get }
    var hasHeader: Bool { get }
    var groupIsHorizontal: Bool { get }
    var inset: NSDirectionalEdgeInsets { get }
    
    func groupLenght() -> CompositionalLayoutGroupLenght
    func groupSize(in environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSize
    func layoutItem() -> NSCollectionLayoutItem
    func layoutItemInsets() -> NSDirectionalEdgeInsets
    func orthogonalScroll() -> UICollectionLayoutSectionOrthogonalScrollingBehavior
}

extension CompositionalLayoutSection {
    func hash(into hasher: inout Hasher) {
        hasher.combine(type)
    }
}

enum CompositionalLayoutGroupLenght {
    case fixed(UInt)
    case max
}
