//
//  CellProviderFactory.swift
//  VCCup2023
//
//  Created by Maxım Gaıssın on 18.12.2022.
//

import UIKit

protocol CellProviderFactory {
    associatedtype ItemIdentifier
    typealias Provider<ItemIdentifier> = (_ collectionView: UICollectionView,
                                          _ indexPath: IndexPath,
                                          _ itemIdentifier: ItemIdentifier) -> UICollectionViewCell?
    
    func make(_ collectionView: UICollectionView) -> Provider<ItemIdentifier>
    func registerCells(_ collectionView: UICollectionView)
}
