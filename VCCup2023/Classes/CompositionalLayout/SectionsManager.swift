//
//  SectionsManager.swift
//  VCCup2023
//
//  Created by Maxım Gaıssın on 18.12.2022.
//

import Foundation

protocol SectionsManager {
    associatedtype Section: CompositionalLayoutSection

    var sections: [Section] { get set }
    func make(_ types: [Section.SectionType]) -> [Section]
}
