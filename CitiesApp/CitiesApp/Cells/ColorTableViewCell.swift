//
//  ColorTableViewCell.swift
//  CitiesApp
//
//  Created by Surgeont on 29.11.2021.
//

import UIKit

class ColorTableViewCell: UITableViewCell {
    
     let backgroundViewOfCell: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Config Cell
    func configureCell(indexPath: IndexPath) {
        switch indexPath.section {
        case 0: backgroundViewOfCell.backgroundColor = UIColor().colorFromHEX("BE2813")
        case 1: backgroundViewOfCell.backgroundColor = UIColor().colorFromHEX("F07F5A")
        case 2: backgroundViewOfCell.backgroundColor = UIColor().colorFromHEX("F3B53B")
        case 3: backgroundViewOfCell.backgroundColor = UIColor().colorFromHEX("467C24")
        case 4: backgroundViewOfCell.backgroundColor = UIColor().colorFromHEX("2D7FC1")
        case 5: backgroundViewOfCell.backgroundColor = UIColor().colorFromHEX("1A4766")
        default: backgroundViewOfCell.backgroundColor = UIColor().colorFromHEX("2D038F")
        }
    }
    
    // MARK: - Constraints
    func setConstraints() {
        self.addSubview(backgroundViewOfCell)
        NSLayoutConstraint.activate([
            backgroundViewOfCell.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            backgroundViewOfCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            backgroundViewOfCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            backgroundViewOfCell.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1)
        ])
    }
}
