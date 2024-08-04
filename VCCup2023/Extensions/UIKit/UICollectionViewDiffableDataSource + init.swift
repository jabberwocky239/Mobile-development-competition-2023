//
//  UICollectionViewDiffableDataSource + init.swift
//  VCCup2023
//
//  Created by Maxım Gaıssın on 18.12.2022.
//

import UIKit

extension UICollectionViewDiffableDataSource {
    typealias Snapshot = NSDiffableDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType>
    
    convenience init<T: CellProviderFactory>(collectionView: UICollectionView,
                                             cellFactory: T,
                                             supplementaryFactory: ((@escaping () -> Snapshot?) -> SupplementaryProviderFactory)?) where T.ItemIdentifier == ItemIdentifierType {
        
        self.init(collectionView: collectionView, cellProvider: cellFactory.make(collectionView))
        if let supplementaryFactory = supplementaryFactory {
            self.supplementaryViewProvider = supplementaryFactory { [weak self] in self?.snapshot() }.make(collectionView)
        }
    }
}
