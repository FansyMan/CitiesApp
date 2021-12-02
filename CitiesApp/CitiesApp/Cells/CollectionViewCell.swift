//
//  CollectionViewCell.swift
//  CitiesApp
//
//  Created by Surgeont on 29.11.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    private let plusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.backgroundColor = .cyan
        imageView.frame.size.width = 120
        imageView.frame.size.height = 120
        imageView.layer.cornerRadius = 60

//        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let backgroundViewOfCell: UIView = {
       var view = UIView()
       view.backgroundColor = .white
        view.layer.cornerRadius = 60
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
   }()
    
    // MARK: - Cell Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupCell(cityList: CityList) {
                    let color = cityList.color
                    backgroundViewOfCell.backgroundColor = UIColor().colorFromHEX(color)

    }
    
    func setupImage() {
        plusImageView.image = UIImage(systemName: "plus")
                    self.addSubview(plusImageView)
    }
    
//    func setupCell(cityList: CityList, indexPath: IndexPath) {
//        if indexPath == [0,0] {
//            plusImageView.image = UIImage(systemName: "plus")
//            self.addSubview(plusImageView)
//        } else {
//            let color = cityList.color
//            backgroundViewOfCell.backgroundColor = UIColor().colorFromHEX(color)
//        }
//    }
    
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

