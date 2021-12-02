//
//  ChooseCityTableViewCell.swift
//  CitiesApp
//
//  Created by Surgeont on 25.11.2021.
//

import UIKit

class ChooseCityTableViewCell: UITableViewCell {
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    var city: City? {
        didSet {
            setupCell()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Cell Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init coder")
    }
    
    // MARK: - Setup Views
    func setupViews() {
//        self.backgroundColor = .clear
//        self.selectionStyle = .none
        self.addSubview(cityLabel)
    }
    
    // MARK: - Setup Cell
    func setupCell() {
        cityLabel.text = city?.name
    }
    
}

// MARK: - Constraints
extension ChooseCityTableViewCell {
    private func setConstraints() {
        
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            cityLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            cityLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            cityLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)

        ])
        
    }
}
