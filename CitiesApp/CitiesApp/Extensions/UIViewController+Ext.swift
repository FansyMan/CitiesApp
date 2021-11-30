//
//  UIViewController+Ext.swift
//  PassportApp
//
//  Created by Surgeont on 24.11.2021.
//

import UIKit

extension UIViewController {
    func createListNamesTextFields(shortNameTextFielf: UITextField, longNameTextFields: UITextField) -> UIView {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        
        let nameLabel = createLabel(text: "Короткое имя списка:")
        let ageLabel = createLabel(text: "Длинное имя списка:")
        
        let nameView = createTextFieldView(textField: shortNameTextFielf, label: nameLabel)
        let ageView = createTextFieldView(textField: longNameTextFields, label: ageLabel)
        
       
        
        let fieldsStackView = UIStackView(arrangedSubviews: [nameView, ageView],
                                          axis: .vertical,
                                          spacing: 10,
                                          distribution: .fillEqually)
        view.addSubview(fieldsStackView)

        NSLayoutConstraint.activate([
            fieldsStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            fieldsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            fieldsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            fieldsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        return view
    }
    
    func createTextFieldView(textField: UITextField, label: UILabel) -> UIView {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray5.cgColor
        view.layer.cornerRadius = 5
        
        let stackView = UIStackView(arrangedSubviews: [label, textField],
                                    axis: .vertical,
                                    spacing: 5,
                                    distribution: .fillProportionally)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5)
        ])
        
        return view
    }
    
    func createLabel(text: String) -> UILabel {
            let label = UILabel()
            label.text = text
            label.font = UIFont.systemFont(ofSize: 15)
            label.tintColor = .systemGray6
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
    }
    
}

