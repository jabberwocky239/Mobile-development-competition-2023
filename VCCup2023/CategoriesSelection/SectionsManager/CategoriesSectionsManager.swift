//
//  CategoriesSectionsManager.swift
//  VCCup2023
//
//  Created by Maxım Gaıssın on 18.12.2022.
//

import UIKit

class CategoriesSectionsManager: SectionsManager {

    // MARK: typeAliases
    typealias Section = CategorySelectionSection
    typealias SectionType = Section.SectionType
    typealias Item = CategorySelectionSection.Item
    
    // MARK: Sections
    var sections: [Section] = []
    
    var selectedSectionsIndexes: [Int] = []
    
    // MARK: - init
    init() {
        sections = make()
    }
    // MARK: - Sections construction
    func make(_ types: [SectionType] = SectionType.allCases) -> [Section] {
        
        types.map { (sectionType) -> Section in
            Section.init(type: sectionType,
                         items: makeItems(sectionType),
                         groupInterItemSpacing: makeGroupInterItemSpacing(sectionType),
                         hasFooter: makeHasFooter(sectionType),
                         hasHeader: makeHasHeader(sectionType),
                         groupIsHorizontal: groupIsHorizontal(sectionType),
                         inset: makeInset(sectionType),
                         title: makeTitle(sectionType))
        }
                                   
    }
}

private extension CategoriesSectionsManager {
    
    // MARK: - Sections constructions helping methods
    func makeItems(_ sectionType: SectionType) -> [Item] {
        switch sectionType {
        case .selectCategoriesLater:
            return [Item(type: .selectCategoriesLaterItem)]
        case .categories:
            return Category.allCases
                .map { Item(type: .categories($0)) }
        }
    }

    func makeGroupInterItemSpacing(_ sectionType: SectionType) -> NSCollectionLayoutSpacing? {
        .fixed(8)
    }

    func makeHasFooter(_ sectionType: SectionType) -> Bool {
        false
    }

    func makeHasHeader(_ sectionType: SectionType) -> Bool {
        false
    }

    func groupIsHorizontal(_ sectionType: SectionType) -> Bool {
        true
    }

    func makeInset(_ sectionType: SectionType) -> NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(top: .zero, leading: 16, bottom: .zero, trailing: 16)
    }

    func makeTitle(_ sectionType: SectionType) -> String? {
        nil
    }
}

