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
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.bounces = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
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
        button.layer.cornerRadius = 40
        button.addTarget(self, action: #selector(jumpToCreateNewListViewControler), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.text = "Выберите список"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        backgroundView.addSubview(cityLabel)
        
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
            addNewListButton.widthAnchor.constraint(equalToConstant: 80),
            addNewListButton.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            collectionView.leadingAnchor.constraint(equalTo: addNewListButton.trailingAnchor, constant: 5),
            collectionView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -15),
            collectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            cityLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            cityLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20)
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
        return CGSize(width: 80, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath)  as? CollectionViewCell
        collectionView.bringSubviewToFront(selectedCell!)

        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 0, options: [], animations: {
            selectedCell?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            })
        
        let list = allLists[indexPath.item]
        let destinaationVC = navigationController?.viewControllers[0] as? CurrentListViewController
        destinaationVC?.currentList = list
        cityLabel.text = list.shortName
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let unselectedCell = collectionView.cellForItem(at: indexPath)  as? CollectionViewCell
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 0, options: [], animations: {
            unselectedCell?.transform = .identity
        })
        
        
        
    }
}
