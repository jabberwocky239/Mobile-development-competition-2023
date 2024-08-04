//
//  CategorySelectionCell.swift
//  VCCup2023
//
//  Created by Maxım Gaıssın on 18.12.2022.
//

import UIKit
import SnapKit

class CategorySelectionCell: UICollectionViewCell {
    //MARK: - Appearance
    struct Appearance {
        static let cornerRadius: CGFloat = 12
        static let deselectedBackgroundColor: UIColor = .init(red: 1, green: 1, blue: 1, alpha: 0.17)
        static let font: UIFont = UIFont(name: "SFPro-Semibold", size: 16) ?? UIFont.systemFont(ofSize: 16)
        static let fontColor: UIColor = .white
        static let separatorColor: UIColor = .init(red: 1, green: 1, blue: 1, alpha: 0.27)
        static let stackViewInsets: UIEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
        static let selectedBackgroundColor: UIColor = .init(red: 1, green: 0.325, blue: 0.09, alpha: 1)
        static let separatorHeight: CGFloat = 20
        static let separatorWidth: CGFloat = 1
    }
    
    enum Style {
        case selected
        case deselected
    }
    
    //MARK: - Overrided properties
    override var isSelected: Bool {
        didSet {
            style = isSelected ? .selected : .deselected
        }
    }
    //MARK: - Subviews
    private(set) lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = Appearance.fontColor
        label.font = Appearance.font
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let image = UIImage(systemName: "plus")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Appearance.fontColor
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(24)
        }
        
        return imageView
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Appearance.separatorColor
        view.snp.makeConstraints {
            $0.width.equalTo(Appearance.separatorWidth)
            $0.height.equalTo(Appearance.separatorHeight)
        }
        return view
    }()
    
    //MARK: - Internal properties
    
    var categoryDescription: String? {
        didSet {
            label.text = categoryDescription
        }
    }
    
    var style: Style = .deselected {
        didSet {
            applyStyle(style)
        }
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    private func setup() {
        layer.cornerRadius = Appearance.cornerRadius
        backgroundColor = Appearance.deselectedBackgroundColor
        
        let stackView = UIStackView(arrangedSubviews: [label, separatorView, imageView])
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 12
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Appearance.stackViewInsets)
        }
    }
    
    private func applyStyle(_ style: Style) {
        switch style {
        case .selected:
            backgroundColor = Appearance.selectedBackgroundColor
            let image = UIImage(systemName: "checkmark")
            imageView.image = image
            
        case .deselected:
            backgroundColor = Appearance.deselectedBackgroundColor
            let image = UIImage(systemName: "plus")
            imageView.image = image
        }
    }
    
}
