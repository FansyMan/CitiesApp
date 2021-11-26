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
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let checkBoxImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        self.addSubview(checkBoxImage)
        self.addSubview(cityLabel)
    }
    
    func setupCell() {
        cityLabel.text = city?.name
        switch city?.picked {
        case true:
            checkBoxImage.image = UIImage(systemName: "checkmark.circle.fill")
        case false:
            checkBoxImage.image = UIImage(systemName: "circle")
        default:
            break
        }
        
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.addTarget(self, action: #selector(pickCity))
        self.addGestureRecognizer(gestureRecognizer)
        
    }
    
    @objc func pickCity() {
        switch city?.picked {
        case true:
            city?.picked = false
        case false:
            city?.picked = true
        default:
            break
        }
    }
    
}

extension ChooseCityTableViewCell {
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            checkBoxImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            checkBoxImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            checkBoxImage.widthAnchor.constraint(equalToConstant: 40),
            checkBoxImage.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            cityLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: checkBoxImage.trailingAnchor, constant: 20),
            cityLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
        
    }
}
