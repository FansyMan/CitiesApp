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
    
    let shortNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.clearButtonMode = .whileEditing
        return textField
    }()

    let longNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.clearButtonMode = .whileEditing
        return textField
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
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.layer.borderWidth = 0
        tableView.isUserInteractionEnabled = true
        tableView.register(ChooseCityTableViewCell.self, forCellReuseIdentifier: "ChooseCityTableViewCell")
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
        return button
    }()
    
    private let colorLabel: UILabel = {
        let label = UILabel()
        label.text = "Выбрать цвет"
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let colorButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 2
        button.layer.borderColor = .none
        button.frame.size.width = 100
        button.frame.size.height = 25
        button.addTarget(self, action: #selector(chooseColor), for: .touchUpInside)
        return button
    }()
    
    private var textFieldsView = UIView()
    private var buttonsStackView = UIStackView()
    private var colorStackView = UIStackView()
    var cities: [City]!
    var service: CitiesService!
    var hexColorCell = "FFFFFF"
    var choosenRows: [Int : Bool] = [:]
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        service = CitiesService()
        cities = service.getCities()
        setupViews()
        setConstraints()
        setupDelegates()
        
        tableView.allowsMultipleSelectionDuringEditing = true
//        tableView.setEditing(true, animated: false)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(hexColorCell)
        colorButton.backgroundColor = UIColor().colorFromHEX(hexColorCell)
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(scrolView)
        view.addSubview(backgroundView)
        
        textFieldsView = createListNamesTextFields(shortNameTextFielf: shortNameTextField, longNameTextFields: longNameTextField)
        buttonsStackView = UIStackView(arrangedSubviews: [cancelButton, saveNewListButton],
                                       axis: .horizontal,
                                       spacing: 10,
                                       distribution: .fillEqually)
        colorStackView = UIStackView(arrangedSubviews: [colorLabel, colorButton],
                                     axis: .horizontal,
                                     spacing: 10,
                                     distribution: .fillEqually)
        
        backgroundView.addSubview(headLabel)
        backgroundView.addSubview(textFieldsView)
        backgroundView.addSubview(colorStackView)
        backgroundView.addSubview(tableView)
        backgroundView.addSubview(buttonsStackView)
    }
    
    // MARK: - SetupDelegates
    private func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Save Button Setup
    @objc private func saveNewList() {
        let newList = CityList(color: hexColorCell,
                               shortName: shortNameTextField.text ?? "unknown",
                               longName: longNameTextField.text ?? "unknown",
                               cities: nil)
        var choosenCities = [City]()
       
        for city in choosenRows {
            let choosenCity = cities[city.key]
            choosenCities.append(choosenCity)
        }
        
        print(choosenCities)
    }
    
    @objc private func dismissCreatingNewList() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - ChooseColor Button
    @objc func chooseColor() {
        let destinationVC = ChooseColorViewController()
        destinationVC.modalPresentationStyle = .fullScreen
        destinationVC.colorDelegate = self
        present(destinationVC, animated: true, completion: nil)
    }
}

// MARK: - Set Constraints
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
            headLabel.topAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.topAnchor, constant: 15),
            headLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            headLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            textFieldsView.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 20),
            textFieldsView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            textFieldsView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
            textFieldsView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            colorStackView.topAnchor.constraint(equalTo: textFieldsView.bottomAnchor, constant: 10),
            colorStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 30),
            colorStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: colorStackView.bottomAnchor, constant: 20),
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

// MARK: - Table View Setups
extension CreateNewListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "ChooseCityTableViewCell", for: indexPath) as! ChooseCityTableViewCell
        
        let city = cities[indexPath.row]
        cell.city = city
        
        if cell.isSelected
                {
            cell.isSelected = false
            if cell.accessoryType == UITableViewCell.AccessoryType.none
                    {
                cell.accessoryType = UITableViewCell.AccessoryType.checkmark
                    }
                    else
                    {
                        cell.accessoryType = UITableViewCell.AccessoryType.none
                    }
                }
            return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        

        if cell!.isSelected
                {
            cell!.isSelected = false
            choosenRows[indexPath.row] = true

            if cell!.accessoryType == UITableViewCell.AccessoryType.none
                    {
                cell!.accessoryType = UITableViewCell.AccessoryType.checkmark
                    }
                    else
                    {
                        cell!.accessoryType = UITableViewCell.AccessoryType.none
                        choosenRows[indexPath.row] = nil
                    }
                }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        choosenRows.removeValue(forKey: indexPath.row)
    }
    
}

extension CreateNewListViewController: ChooseColorProtocol {
    func updateColor(color: String) {
        hexColorCell = color
    }
    
    
}
