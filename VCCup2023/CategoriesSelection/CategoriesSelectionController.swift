//
//  CategoriesSelectionController.swift
//  VCCup2023
//
//  Created by Maxım Gaıssın on 17.12.2022.
//

import UIKit
import SnapKit

typealias CategoriesSelectionDataSource = UICollectionViewDiffableDataSource<CategorySelectionSection, CategorySelectionSection.Item>


final class CategoriesSelectionController: UIViewController {
 
    //MARK: - View
    private let collectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: UICollectionViewLayout())
    private let continueButton = UIButton()
    
    //MARK: - ViewModel
    let viewModel: CategoriesSelectionViewModel
    
    //MARK: - DataSource
    private lazy var dataSource: CategoriesSelectionDataSource = {
        return .init(collectionView: collectionView,
                     cellFactory: CategoriesSelectionCellProvierFactory(controller: self),
                     supplementaryFactory: nil)
    }()
    
    //MARK: - Layout
    private lazy var sectionsLayoutFactory = CompositionalLayoutFactory<CategorySelectionSection>(
        appearance: .init(
            headerSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(52)),
            footerSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(8)),
            headerInset: .init(top: 0, leading: 16, bottom: 0, trailing: 16),
            footerInset: .zero
        )
    )
    
    //MARK: - Init
    init(viewModel: CategoriesSelectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Overrided methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupCollectionView()
        setupButton()
        applySnapshot()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setSelection()
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        collectionView.collectionViewLayout = collectionViewLayout()
        collectionView.allowsMultipleSelection = true
        collectionView.backgroundColor = .systemBackground
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 90, right: 0)
        collectionView.delegate = self
        collectionView.backgroundColor = .black
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { [weak self] (index, environment) -> NSCollectionLayoutSection? in
            guard let sections = self?.viewModel.sectionsManager.sections,
                  index < sections.count else {
                return nil
            }
            
            return self?.sectionsLayoutFactory.layout(sections[index], in: environment)
        }
    }
    private func setupButton() {
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font : UIFont(name: "YSText-Medium", size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .medium),
            .foregroundColor : UIColor.black
        ]
        let titleString: NSAttributedString = .init(string: "Continue", attributes: attributes)
        continueButton.setTitleColor(.black, for: .normal)
        
        continueButton.setAttributedTitle(titleString, for: .normal)
        continueButton.addTarget(self, action: #selector(handleContinueButtonTouch), for: .touchUpInside)
        continueButton.backgroundColor = .white
        view.addSubview(continueButton)
        continueButton.layer.cornerRadius = 37
        continueButton.snp.makeConstraints {
            $0.height.equalTo(80)
            $0.width.equalTo(211)
            $0.bottom.equalToSuperview().inset(68)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setSelection() {
        //TODO: set initial selection for predefined cases
    }
    
    private func applySnapshot() {
        var snapshot = CategoriesSelectionDataSource.Snapshot()
        snapshot.appendSections(viewModel.sectionsManager.sections)
        viewModel.sectionsManager.sections.forEach {
            snapshot.appendItems($0.items, toSection: $0)
        }
            dataSource.apply(snapshot)
    }
    
    @objc private func handleContinueButtonTouch() {
        viewModel.navigateToNextScreen()
    }
}

//MARK: - CollectionView Delegate
extension CategoriesSelectionController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        let section = dataSource.snapshot().sectionIdentifiers[indexPath.section]
        switch section.type {
        case .selectCategoriesLater:
            return false
        case .categories:
            return true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let section = dataSource.snapshot().sectionIdentifiers[indexPath.section]
        switch section.type {
        case .selectCategoriesLater:
            return false
        case .categories:
            return true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        switch item.type {
        case .categories(let category):
            viewModel.addToSelectedCategory(category)
        default:
            break
        }
    }
}

//MARK: - SelectCategoriesLaterCell Delegate
extension CategoriesSelectionController: SelectCategoriesLaterCellDelegate {
    func handleButtonTouch(in: SelectCategoriesLaterCell) {
        viewModel.selectedCategories = .init()
        viewModel.navigateToNextScreen()
    }
}
