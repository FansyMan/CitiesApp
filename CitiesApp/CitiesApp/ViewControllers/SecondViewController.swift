//
//  SecondViewController.swift
//  CitiesApp
//
//  Created by Surgeont on 25.11.2021.
//

import UIKit

class SecondViewController: UIViewController {
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var fullScreenMode: Bool!
    var service: ListService!
    var allLists: [CityList]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Second"
        
        service = ListService()
        allLists = service.getKists()
        
        setupViews()
        setupDelegates()
        setConstraints()
        swipesActions()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
        
    }
    
    private func swipesActions() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(fullScreenActivate))
        swipeUp.direction = .up
        backgroundView.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(fullScreenDismiss))
        swipeDown.direction = .down
        backgroundView.addGestureRecognizer(swipeDown)
        
    }
    
    @objc func fullScreenActivate() {
        backgroundView.backgroundColor = .blue
        
        
    }
    
    @objc func fullScreenDismiss() {
        backgroundView.backgroundColor = .red
    }
    
    private func setupViews() {
        
        view.addSubview(backgroundView)
        backgroundView.addSubview(collectionView)
    }
    
    private func setupDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}


extension SecondViewController {
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            backgroundView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            backgroundView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/2)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            collectionView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-30),
            collectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
        
}

extension SecondViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell {
            let list = allLists[indexPath.item]
            cell.cityList = list
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let list = allLists[indexPath.item]
        let destinationVC = CurrentListViewController()
        destinationVC.currentList = list
    }
    
    
}
