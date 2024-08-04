//
//  SupplementaryProviderFactory.swift
//  VCCup2023
//
//  Created by Maxım Gaıssın on 18.12.2022.
//

import UIKit

protocol SupplementaryProviderFactory {
    typealias Provider = (_ collectionView: UICollectionView,
                          _ elementKind: String,
                          _ indexPath: IndexPath) -> UICollectionReusableView?
    func make(_ collectionView: UICollectionView) -> Provider
    func registerSupplementaryViews(_ collectionView: UICollectionView)
}
