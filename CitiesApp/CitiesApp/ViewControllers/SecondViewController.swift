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
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let addNewListButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = UIColor.systemBlue
        button.layer.cornerRadius = 50
        button.addTarget(self, action: #selector(jumpToCreateNewListViewControler), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var fullScreenMode: Bool!
    var service: ListService!
    var allLists: [CityList]!
    
    // MARK: - View Did Load
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
    
    // MARK: - Swipes Setup
    private func swipesActions() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(fullScreenActivate))
        swipeUp.direction = .up
        backgroundView.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(fullScreenDismiss))
        swipeDown.direction = .down
        backgroundView.addGestureRecognizer(swipeDown)
        
    }
    
    // MARK: - Objc
    @objc func fullScreenActivate() {
        backgroundView.backgroundColor = .blue
    }
    
    @objc func jumpToCreateNewListViewControler() {
        let destinationVC = CreateNewListViewController()
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    @objc func fullScreenDismiss() {
        backgroundView.backgroundColor = .systemGray5
    }
    
    // MARK: - SetupViews
    private func setupViews() {
        view.addSubview(backgroundView)
        backgroundView.addSubview(addNewListButton)
        backgroundView.addSubview(collectionView)
        
    }
    
    // MARK: - SetupDelegates
    private func setupDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

// MARK: - Constraints
extension SecondViewController {
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            backgroundView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            backgroundView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/2)
        ])
        
        NSLayoutConstraint.activate([
            addNewListButton.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            addNewListButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 15),
            addNewListButton.widthAnchor.constraint(equalToConstant: 100),
            addNewListButton.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            collectionView.leadingAnchor.constraint(equalTo: addNewListButton.trailingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -15),
            collectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
        
}

// MARK: - Collection View Setups
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
        let destinationVC = self.navigationController?.viewControllers[1] as? CurrentListViewController
        destinationVC?.currentList = list
        self.navigationController?.pushViewController(destinationVC!, animated: true)
        
    }  
}
