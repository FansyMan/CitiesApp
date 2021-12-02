//
//  SecondViewController.swift
//  CitiesApp
//
//  Created by Surgeont on 25.11.2021.
//

import UIKit

class SecondViewController: UIViewController {
    
    
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.bounces = false
        collectionView.backgroundColor = .systemGray4
        collectionView.isPagingEnabled = true
        collectionView.contentInset = UIEdgeInsets(top: (140-120)/2, left: (UIScreen.main.bounds.width-120)/2, bottom: (140-120)/2, right: (UIScreen.main.bounds.width-120)/2)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.text = "Выберите список"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tapBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let chooseCurrentListButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.tintColor = UIColor.systemBlue
        button.layer.cornerRadius = 25
        button.setTitle("Создать", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let listButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.tintColor = UIColor.systemBlue
        button.layer.cornerRadius = 25
        button.setImage(UIImage(systemName: "list.dash"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var service: ListService!
    var allLists: [CityList]!
    weak var listDelegate: UpdateCurrentList?
    

    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        service = ListService()
        allLists = service.getKists()
        
        setupViews()
        setupDelegates()
        setConstraints()
    }
    // MARK: - SetupViews
    private func setupViews() {
        view.addSubview(tapBarView)
        tapBarView.addSubview(chooseCurrentListButton)
        tapBarView.addSubview(listButton)
        view.addSubview(collectionView)
        view.addSubview(cityLabel)
        
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
            tapBarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            tapBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tapBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tapBarView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            listButton.centerYAnchor.constraint(equalTo: tapBarView.centerYAnchor),
            listButton.leadingAnchor.constraint(equalTo: tapBarView.leadingAnchor, constant: 20),
            listButton.widthAnchor.constraint(equalToConstant: 100),
            listButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            chooseCurrentListButton.centerYAnchor.constraint(equalTo: tapBarView.centerYAnchor),
            chooseCurrentListButton.trailingAnchor.constraint(equalTo: tapBarView.trailingAnchor, constant: -20),
            chooseCurrentListButton.widthAnchor.constraint(equalToConstant: 100),
            chooseCurrentListButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: tapBarView.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.heightAnchor.constraint(equalToConstant: 140)
        ])

        NSLayoutConstraint.activate([
            cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20)
        ])
    }
        
}

// MARK: - Collection View Setups
extension SecondViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
            
        if indexPath == [0,0] {
            cell.setupImage()
        } else {
            let list = allLists[indexPath.item-1]
            cell.setupCell(cityList: list)
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath)  as? CollectionViewCell
        collectionView.bringSubviewToFront(selectedCell!)

        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 0, options: [], animations: {
            selectedCell?.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            })
        
        if indexPath == [0,0] {
            let destinationVC = CreateNewListViewController()
            destinationVC.modalPresentationStyle = .automatic
            present(destinationVC, animated: true, completion: nil)
        } else {
        
        let list = allLists[indexPath.item-1]
        listDelegate?.updateCityList(list: list)
        cityLabel.text = list.shortName
        dismiss(animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let unselectedCell = collectionView.cellForItem(at: indexPath)  as? CollectionViewCell
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 0, options: [], animations: {
            unselectedCell?.transform = .identity
        })
    }
    
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        let cellWithIncludingSpacing = 160 + layout.minimumLineSpacing
//        
//        var offset = targetContentOffset.pointee
//        let index = (offset.x + scrollView.contentInset.left) / cellWithIncludingSpacing
//        let roundedIndex = round(index)
//        
//        offset = CGPoint(x: roundedIndex * cellWithIncludingSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
//        
//        targetContentOffset.pointee = offset
//        
//        
//    }
    
    
}
