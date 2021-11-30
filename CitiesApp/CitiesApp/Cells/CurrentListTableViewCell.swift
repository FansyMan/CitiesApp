//
//  CurrentListTableViewCell.swift
//  CitiesApp
//
//  Created by Surgeont on 29.11.2021.
//

import UIKit

class CurrentListTableViewCell: UITableViewCell {
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    var stackView = UIStackView()
    var city: City? {
        didSet {
            setupCell()
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init coder")
    }
    
    func setupViews() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        stackView = UIStackView(arrangedSubviews: [cityLabel, ageLabel],
                                axis: .horizontal,
                                spacing: 10,
                                distribution: .fillEqually)
        self.addSubview(stackView)
    }
    
    func setupCell() {
        cityLabel.text = city?.name
        ageLabel.text = city?.age
        
        
    }
}

extension CurrentListTableViewCell {
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
}
