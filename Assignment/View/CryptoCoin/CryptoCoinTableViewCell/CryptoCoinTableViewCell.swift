//
//  CryptoCoinTableViewCell.swift
//  Assignment
//
//  Created by Neha Jain on 14/11/2024.
//

import UIKit

class CryptoCoinTableViewCell: UITableViewCell {
    static let identifier = "CryptoCoinTableViewCell"
    
    private let nameLabel = UILabel()
    private let symbolLabel = UILabel()
    private let coinIcon = UIImageView()
    private let newBadgeIcon = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        //MARK: Seperator leading spacing
        self.separatorInset = UIEdgeInsets.zero
        
        //MARK: Configure name label
        nameLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .medium)
        nameLabel.textColor = .black
        contentView.addSubview(nameLabel)
        
        //MARK: Configure symbol label
        symbolLabel.font = UIFont.systemFont(ofSize: 15)
        symbolLabel.textColor = .darkGray
        contentView.addSubview(symbolLabel)
        
        //MARK: Configure status indicator view (if needed)
        coinIcon.contentMode = .scaleAspectFit
        contentView.addSubview(coinIcon)
        
        //MARK: Configure status indicator view (if needed)
        newBadgeIcon.contentMode = .scaleAspectFit
        contentView.addSubview(newBadgeIcon)
    }
    
    private func setupConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false
        coinIcon.translatesAutoresizingMaskIntoConstraints = false
        newBadgeIcon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            //MARK: Name Label constraints
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: coinIcon.leadingAnchor, constant: -8),
            
            //MARK: Symbol Label constraints
            symbolLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            symbolLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            symbolLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            //MARK: Status Indicator View constraints
            coinIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            coinIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            coinIcon.widthAnchor.constraint(equalToConstant: 32),
            coinIcon.heightAnchor.constraint(equalToConstant: 32),
            
            //MARK: Symbol Label constraints
            symbolLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            symbolLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            symbolLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            //MARK: NewBadgeIcon constraints
            newBadgeIcon.topAnchor.constraint(equalTo: coinIcon.topAnchor, constant: 0),
            newBadgeIcon.trailingAnchor.constraint(equalTo: coinIcon.trailingAnchor, constant: 0),
            newBadgeIcon.widthAnchor.constraint(equalToConstant: 20),
            newBadgeIcon.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configure(with coin: CryptoCoinModel) {
        nameLabel.text = coin.name
        symbolLabel.text = coin.symbol?.uppercased()
        contentView.alpha = coin.isActive ?? false  ? 1.0 : 0.4
        
        //MARK: Placeholder for coinIcon and newBadgeIcon
        coinIcon.image = (coin.isActive ?? false) ? UIImage(named: coin.type?.lowercased() ?? "") : UIImage(named: "disabled_coin")
        newBadgeIcon.image = coin.isNew ?? false ? UIImage(named: "new") : UIImage()
    }
}
