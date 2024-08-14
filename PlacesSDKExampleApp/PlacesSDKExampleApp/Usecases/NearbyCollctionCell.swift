//
//  NearbyCollctionCell.swift
//  OlaMapServicesExample
//
//  Created by Zeeshan Khundmiri on 05/08/24.
//

import UIKit

class NearbyCategoryModel {
    var categoryName: String
    var isSelected: Bool = false
    
    init(categoryName: String, isSelected: Bool) {
        self.categoryName = categoryName
        self.isSelected = isSelected
    }
}

final class NearbyCollectionCell: UICollectionViewCell {
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1.0
        return view
    }()
    
    lazy var categoryName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font =  UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        self.containerView.backgroundColor = .white
        self.contentView.addSubview(containerView)
        self.containerView.addSubview(categoryName)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            categoryName.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 16),
            categoryName.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -16),
            categoryName.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }
    
    func setupCell(model: NearbyCategoryModel) {
        categoryName.text = model.categoryName
        
        if model.isSelected {
            self.categoryName.textColor = .white
            self.containerView.backgroundColor = .black
        }else {
            self.categoryName.textColor = .black
            self.containerView.backgroundColor = .white
        }
        
    }
    
    
}
