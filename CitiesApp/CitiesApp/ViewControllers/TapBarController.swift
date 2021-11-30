//
//  TapBarController.swift
//  CitiesApp
//
//  Created by Surgeont on 25.11.2021.
//

import UIKit

class TapBarController: UITabBarController {
    
    override func viewDidLoad() {
        
        setupTapBar()
    }
    
    func setupTapBar() {
        
        let currentListVC = createControllers(viewController: CurrentListViewController(), itemName: "Cities", itemImage: "list.dash")
        let secondVC = createControllers(viewController: SecondViewController(), itemName: "second", itemImage: "sun.max")
//        let createVC = createControllers(viewController: CreateNewListViewController(), itemName: "create", itemImage: "plus")
        
        
        viewControllers = [currentListVC, secondVC]
        
    }
    
    
    func createControllers(viewController: UIViewController, itemName: String, itemImage: String) -> UINavigationController {
        
        let item = UITabBarItem(title: itemName, image: UIImage(systemName: itemImage)?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        item.titlePositionAdjustment = .init(horizontal: 0, vertical: 10)
        
        
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = item
        
        return navigationController
        
    }
    
}
