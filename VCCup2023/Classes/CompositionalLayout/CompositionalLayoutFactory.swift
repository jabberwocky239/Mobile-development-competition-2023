//
//  CompositionalLayoutFactory.swift
//  VCCup2023
//
//  Created by Maxım Gaıssın on 18.12.2022.
//
import UIKit

protocol CollectionSectionLayoutFactory {

    associatedtype Section: Hashable

    var headerItem: NSCollectionLayoutBoundarySupplementaryItem? { get set }
    var footerItem: NSCollectionLayoutBoundarySupplementaryItem? { get set }

    func layout(_ section: Section, in environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection?

}

class CompositionalLayoutFactory<LayoutSection: CompositionalLayoutSection>: CollectionSectionLayoutFactory {
    typealias Section = LayoutSection

    struct Appearance {
        let headerSize: NSCollectionLayoutSize
        let footerSize: NSCollectionLayoutSize

        let headerInset: NSDirectionalEdgeInsets
        let footerInset: NSDirectionalEdgeInsets
    }
    
    let appearance: Appearance
    var headerItem: NSCollectionLayoutBoundarySupplementaryItem?
    var footerItem: NSCollectionLayoutBoundarySupplementaryItem?
    
    init(appearance: Appearance) {
        self.appearance = appearance
        
        headerItem = .init(
            layoutSize: appearance.headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading)
        
        footerItem = .init(
            layoutSize: appearance.footerSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom)
        
    }
    
    func layout(_ section: Section, in environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        let groupSize: NSCollectionLayoutSize
        let group: NSCollectionLayoutGroup
        var layoutSection: NSCollectionLayoutSection
        var supplementaries: [String]
        
        let itemsCount: Int
        switch section.groupLenght() {
        case .fixed(let lenght):
            itemsCount = Int(lenght)
        case .max:
            itemsCount = section.items.count
            
        }
        let layoutItem = section.layoutItem()
        layoutItem.contentInsets = section.layoutItemInsets()
        let layoutItems = Array(repeating: layoutItem, count: itemsCount)
        
        groupSize = section.groupSize(in: environment)
        
        if section.groupIsHorizontal {
            group = .horizontal(layoutSize: groupSize, subitems: layoutItems)
        } else {
            group = .vertical(layoutSize: groupSize, subitems: layoutItems)
        }
        
       group.interItemSpacing = section.groupInterItemSpacing
        
        
        layoutSection = NSCollectionLayoutSection(group: group)
        layoutSection.contentInsets = section.inset
        supplementaries = []
        if section.hasFooter {
            supplementaries.append(UICollectionView.elementKindSectionFooter)
        }
        if section.hasHeader {
            supplementaries.append(UICollectionView.elementKindSectionHeader)
        }
        
        if !supplementaries.isEmpty {
            add(supplementaries, to: &layoutSection)
            layoutSection.supplementariesFollowContentInsets = false
        }
        
        layoutSection.orthogonalScrollingBehavior = section.orthogonalScroll()
        return layoutSection
    }
    
    private func add(_ supplementaryItemsOfKind: [String], to section: inout NSCollectionLayoutSection) {
        guard !supplementaryItemsOfKind.isEmpty else {
            return
        }

        var boundarySupplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem] = []
        if supplementaryItemsOfKind.contains(UICollectionView.elementKindSectionHeader) {
            guard let header = headerItem else {
                return
            }

            header.contentInsets = appearance.headerInset
            boundarySupplementaryItems.append(header)
        }

        if supplementaryItemsOfKind.contains(UICollectionView.elementKindSectionFooter) {
            guard let footer = footerItem else {
                return
            }

            footer.contentInsets = appearance.footerInset
            boundarySupplementaryItems.append(footer)
        }

        section.boundarySupplementaryItems = boundarySupplementaryItems
    }

}
