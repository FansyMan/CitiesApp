//
//  CurrentListViewController.swift
//  CitiesApp
//
//  Created by Surgeont on 25.11.2021.
//

import UIKit

class CurrentListViewController: UIViewController {
    
    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.layer.borderWidth = 0
        tableView.register(CurrentListTableViewCell.self, forCellReuseIdentifier: "CurrentListTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var currentList: CityList?
    var cities: [City] = []
    var service: ListService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Cities"
        
        setupViews()
        setConstraints()
        setupDelegates()
        service = ListService()
        let allLists = service.getKists()
        currentList = allLists[2]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let currentList = currentList else { return }
        cities = currentList.cities!
        tableView.reloadData()
        
    }
    
    private func setupViews() {
        view.addSubview(tableView)
    }
    
    private func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension CurrentListViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }

}

extension CurrentListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentListTableViewCell", for: indexPath) as! CurrentListTableViewCell
        cell.city = cities[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
}
