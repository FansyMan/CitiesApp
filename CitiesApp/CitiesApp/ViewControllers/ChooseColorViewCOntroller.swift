//
//  ChooseColorViewCOntroller.swift
//  CitiesApp
//
//  Created by Surgeont on 28.11.2021.
//

import UIKit

class ChooseColorViewController: UITableViewController {
    private let colorTableViewCell = "ColorTableViewCell"
    private let idColorHeader = "idColorHeader"
    
    let headerNames = ["RED","ORANGE","YELLOW","GREEN","BLUE","DEEP BLUE","PURPLE"]
    
//    private var citiesList: CityList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.register(ColorTableViewCell.self, forCellReuseIdentifier: colorTableViewCell)
        tableView.register(HeaderTableViewCell.self, forHeaderFooterViewReuseIdentifier: idColorHeader)
        
        title = "Выбрать цвет списка"
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: colorTableViewCell, for: indexPath) as! ColorTableViewCell
        cell.configureCell(indexPath: indexPath)
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idColorHeader) as! HeaderTableViewCell 
            header.headerConfigure(array: headerNames, section: section)
            return header
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0: setColors(color: "BE2813")
        case 1: setColors(color: "F07F5A")
        case 2: setColors(color: "F07F5A")
        case 3: setColors(color: "467C24")
        case 4: setColors(color: "2D7FC1")
        case 5: setColors(color: "1A4766")
        case 6: setColors(color: "2D038F")
        default: setColors(color: "FFFFFF")
        }
    }
    
    private func setColors(color: String) {
        let destinationVC = self.navigationController?.viewControllers[0] as? CreateNewListViewController
        destinationVC?.hexColorCell = color
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
