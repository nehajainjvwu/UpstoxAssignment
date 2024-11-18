//
//  FilterOptionCollectionViewCell.swift
//  Assignment
//
//  Created by Neha Jain on 17/11/24.
//

import UIKit

class FilterOptionCollectionViewCell: UICollectionViewCell {
    static let identifier = "FilterOptionCollectionViewCell"
    
    //MARK: Lazy initialization of the Filter Button
    lazy var filterButton: UIButton = {
        let titleButton = UIButton()
        titleButton.translatesAutoresizingMaskIntoConstraints = false
        titleButton.contentMode = .scaleAspectFit
        return titleButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Configure the cell with the image name
    /// Parameter: filterOption
    func configure(with filterOption: FilterOptionStruct, isSelected: Bool = false) {
        filterButton.setTitle(filterOption.name, for: .normal)
        filterButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        filterButton.layer.cornerRadius = 12.0
        filterButton.isUserInteractionEnabled = false
        filterButton.layer.borderColor = UIColor(named: "coin_purple")?.cgColor
        filterButton.layer.borderWidth = 1.0

        setupButton(isSelected: isSelected)
    }
    
    private func setupButton(isSelected: Bool) {
        var checkmark_image = UIImage(systemName: "checkmark")

        if isSelected {
            filterButton.setTitleColor(.white, for: .normal)
            filterButton.backgroundColor = UIColor(named: "coin_purple")
            filterButton.tintColor = .white
        } else {
            filterButton.setTitleColor(.black, for: .normal)
            filterButton.backgroundColor = UIColor.clear
            checkmark_image = UIImage(systemName: "")
        }
        filterButton.setImage(checkmark_image, for: .normal)
    }
    
    //MARK: Setup Layout for FilterButton
    private func setupView() {
        contentView.addSubview(filterButton)
        NSLayoutConstraint.activate([
            filterButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            filterButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            filterButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            filterButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
