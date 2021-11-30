//
//  CollectionViewCell.swift
//  CitiesApp
//
//  Created by Surgeont on 29.11.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    let backgroundViewOfCell: UIView = {
       var view = UIView()
       view.backgroundColor = .white
       view.layer.cornerRadius = 40
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
   }()
    
    var cityList: CityList? {
        didSet{
            setupCell()
        }
    }
    
    // MARK: - Cell Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundViewOfCell.backgroundColor = .red
        setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Cell Setup
    func setupCell() {
        guard let cityList = cityList else { return }
        let color = cityList.color
        backgroundViewOfCell.backgroundColor = UIColor().colorFromHEX(color)
    }
    
    // MARK: - Constraints
    func setConstraints() {
        self.addSubview(backgroundViewOfCell)
        NSLayoutConstraint.activate([
            backgroundViewOfCell.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            backgroundViewOfCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            backgroundViewOfCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            backgroundViewOfCell.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
}

