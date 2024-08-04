//
//  SelectCategoriesLaterCell.swift
//  VCCup2023
//
//  Created by Maxım Gaıssın on 18.12.2022.
//

import UIKit

protocol SelectCategoriesLaterCellDelegate: AnyObject {
    func handleButtonTouch(in: SelectCategoriesLaterCell)
}

class SelectCategoriesLaterCell: UICollectionViewCell {
    //MARK: - Appearance
    struct Appearance {
        static let buttonCornerRadius: CGFloat = 20
        static let font: UIFont = UIFont(name: "SFPro-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16)
        static let fontColor: UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.48)
        static let buttonSize: CGSize = .init(width: 79, height: 40)
        static let buttonBackgroundColor: UIColor = .init(red: 1, green: 1, blue: 1, alpha: 0.12)
        static let text: String =
        "Mark what you\u{00a0}are\u{00a0}interested\u{00a0}in to\u{00a0}set up Zen"
//        "Отметьте то, что\u{00a0}вам интересно, чтобы настроить\u{00a0}Дзен"
        static let buttonTitle: String = "Позже"
        static let buttonTitleColor: UIColor = .white
    }

    //MARK: - Subviews
    private(set) lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = Appearance.fontColor
        label.font = Appearance.font
        label.text = Appearance.text
        
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.snp.makeConstraints {
            $0.width.equalTo(Appearance.buttonSize.width)
            $0.height.equalTo(Appearance.buttonSize.height)
        }
        button.setTitle(Appearance.buttonTitle, for: .normal)
        button.setTitleColor(Appearance.buttonTitleColor, for: .normal)
        button.addTarget(self, action: #selector(handleButtonTouch), for: .touchUpInside)
        button.backgroundColor = Appearance.buttonBackgroundColor
        button.layer.cornerRadius = Appearance.buttonCornerRadius
        
        return button
    }()
    
    
    //MARK: - Internal properties
    weak var delegate: SelectCategoriesLaterCellDelegate?
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    
    @objc private func handleButtonTouch() {
        delegate?.handleButtonTouch(in: self)
    }
    
    private func setup() {
        
        let stackView = UIStackView(arrangedSubviews: [label, button])
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 12
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }    
}
