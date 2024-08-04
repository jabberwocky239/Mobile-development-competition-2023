//
//  NSCollectionLayoutItem + Init.swift
//  VCCup2023
//
//  Created by Maxım Gaıssın on 18.12.2022.
//

import UIKit

extension NSCollectionLayoutItem {
    convenience init(width: NSCollectionLayoutDimension, height: NSCollectionLayoutDimension) {
        let size = NSCollectionLayoutSize(widthDimension: width, heightDimension: height)
        self.init(layoutSize: size)
    }
}
