//
//  CreateNewListViewController.swift
//  CitiesApp
//
//  Created by Surgeont on 25.11.2021.
//

import UIKit

class CreateNewListViewController: UIViewController {
    
    private let scrolView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let headLabel: UILabel = {
        let label = UILabel()
        label.text = "Создать новый список"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.layer.borderWidth = 0
        tableView.register(ChooseCityTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let saveNewListButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.setTitle("Создать", for: .normal)
        button.tintColor = UIColor.systemBlue
        button.layer.cornerRadius = 25
        button.frame.size.width = 250
        button.frame.size.height = 50
        button.addTarget(self, action: #selector(saveNewList), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints =  false
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.red.cgColor
        button.setTitle("Отмена", for: .normal)
        button.tintColor = UIColor.red
        button.layer.cornerRadius = 25
        button.frame.size.width = 250
        button.frame.size.height = 100
        button.addTarget(self, action: #selector(dismissCreatingNewList), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints =  false
        return button
    }()
    
    private var textFieldsView = UIView()
    private var buttonsStackView = UIStackView()
    var cities: [City]!
    var service: CitiesService!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        service = CitiesService()
        cities = service.getCities()
        
        setupViews()
        setConstraints()
        setupDelegates()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        title = "Create"
        view.addSubview(scrolView)
        view.addSubview(backgroundView)
        
        textFieldsView = createListNamesTextFields()
        buttonsStackView = UIStackView(arrangedSubviews: [cancelButton, saveNewListButton],
                                       axis: .horizontal,
                                       spacing: 10,
                                       distribution: .fillEqually)
        
        backgroundView.addSubview(headLabel)
        backgroundView.addSubview(textFieldsView)
        backgroundView.addSubview(tableView)
        backgroundView.addSubview(buttonsStackView)
    }
    
    private func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc private func saveNewList() {
        
    }
    
    @objc private func dismissCreatingNewList() {
        
    }
}

extension CreateNewListViewController {
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            scrolView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrolView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrolView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrolView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            backgroundView.centerXAnchor.constraint(equalTo: scrolView.centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: scrolView.centerYAnchor),
            backgroundView.heightAnchor.constraint(equalTo: view.heightAnchor),
            backgroundView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            headLabel.topAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.topAnchor, constant: 30),
            headLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            headLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            textFieldsView.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 30),
            textFieldsView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            textFieldsView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
            textFieldsView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: textFieldsView.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: 0),
            tableView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            buttonsStackView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 40),
            buttonsStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
       
        
    }
}


extension CreateNewListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ChooseCityTableViewCell {
            let city = cities[indexPath.row]
            cell.city = city
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
