//
//  CurrentListViewController.swift
//  CitiesApp
//
//  Created by Surgeont on 25.11.2021.
//

import UIKit
import FloatingPanel

class CurrentListViewController: UIViewController, FloatingPanelControllerDelegate {
    
    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.bounces = false
//        tableView.layer.borderWidth = 0
        tableView.register(CurrentListTableViewCell.self, forCellReuseIdentifier: "CurrentListTableViewCell")
        tableView.isUserInteractionEnabled = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let tapBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Выберите список"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let chooseCurrentListButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.tintColor = UIColor.systemBlue
        button.setTitle("Создать", for: .normal)
        button.addTarget(self, action: #selector(goToSecondViewController), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var currentList: CityList?
    var cities: [City] = []
    var service: ListService!

    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
            
        setupViews()
        setConstraints()
        setupDelegates()
        service = ListService()
        
        
        
        let fps = FloatingPanelController()
        
        fps.delegate = self
        
        let destinationVC = SecondViewController()
        fps.set(contentViewController: destinationVC)
        
        fps.addPanel(toParent: self)
        
        
        
        let longpress = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureRecognized(gestureRecognizer:)))
            self.tableView.addGestureRecognizer(longpress)
    }
    
    // MARK: - View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let allLists = service.getKists()
//        currentList = allLists[2]
        let listTitle = currentList?.shortName
        titleLabel.text = listTitle
        guard let currentList = currentList else { return }
        cities = currentList.cities!
        tableView.reloadData()
        
    }
    
    // MARK: - Setup Views
    private func setupViews() {

        view.addSubview(titleLabel)
        view.addSubview(chooseCurrentListButton)
        view.addSubview(tableView)
//        view.addSubview(tapBarView)
//        tapBarView.addSubview(chooseCurrentListButton)
    }
    
    // MARK: - SetupDelegates
    private func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Gesture Setup
    @objc func longPressGestureRecognized(gestureRecognizer: UIGestureRecognizer) {

        let longpress = gestureRecognizer as! UILongPressGestureRecognizer
        let state = longpress.state
        let locationInView = longpress.location(in: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: locationInView)
        
        switch state {
            case .began:
                if indexPath != nil {
                    Path.initialIndexPath = indexPath
                    let cell = self.tableView.cellForRow(at: indexPath!) as! CurrentListTableViewCell
                    My.cellSnapShot = snapshopOfCell(inputView: cell)
                    var center = cell.center
                    My.cellSnapShot?.center = center
                    My.cellSnapShot?.alpha = 0.0
                    self.tableView.addSubview(My.cellSnapShot!)
                    
                    UIView.animate(withDuration: 0.25, animations: {
                                    center.y = locationInView.y
                                    My.cellSnapShot?.center = center
                                    My.cellSnapShot?.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                                    My.cellSnapShot?.alpha = 0.98
                                    cell.alpha = 0.0
                                }, completion: { (finished) -> Void in
                                    if finished {
                                        cell.isHidden = true
                                    }
                                })
                            }
        case .changed:
                var center = My.cellSnapShot?.center
                center?.y = locationInView.y
                My.cellSnapShot?.center = center!
                if ((indexPath != nil) && (indexPath != Path.initialIndexPath)) {
                    self.cities.swapAt((indexPath?.row)!, (Path.initialIndexPath?.row)!)
                    //swap(&self.wayPoints[(indexPath?.row)!], &self.wayPoints[(Path.initialIndexPath?.row)!])
                    self.tableView.moveRow(at: Path.initialIndexPath!, to: indexPath!)
                    Path.initialIndexPath = indexPath
                }
            
        default:
                let cell = self.tableView.cellForRow(at: Path.initialIndexPath!) as! CurrentListTableViewCell
                cell.isHidden = false
                cell.alpha = 0.0
                UIView.animate(withDuration: 0.25, animations: {
                    My.cellSnapShot?.center = cell.center
                    My.cellSnapShot?.transform = .identity
                    My.cellSnapShot?.alpha = 0.0
                    cell.alpha = 1.0
                }, completion: { (finished) -> Void in
                    if finished {
                        Path.initialIndexPath = nil
                        My.cellSnapShot?.removeFromSuperview()
                        My.cellSnapShot = nil
                    }
                })
            }
        }
    
    // MARK: - SnapshotCell
    func snapshopOfCell(inputView: UIView) -> UIView {

        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0.0)
        inputView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        let cellSnapshot : UIView = UIImageView(image: image)
        cellSnapshot.layer.masksToBounds = false
        cellSnapshot.layer.cornerRadius = 0.0
        cellSnapshot.layer.shadowOffset = CGSize(width: -5.0, height: 0.0)
        cellSnapshot.layer.shadowRadius = 5.0
        cellSnapshot.layer.shadowOpacity = 0.4
        return cellSnapshot
    }
    
    struct My {
        static var cellSnapShot: UIView? = nil
    }

    struct Path {
        static var initialIndexPath: IndexPath? = nil
    }
    
    @objc func goToSecondViewController() {
        let destinationVC = GGGG()
        destinationVC.modalPresentationStyle = .fullScreen
        destinationVC.listDelegate = self
        present(destinationVC, animated: true, completion: nil)
    }
}

// MARK: - Constraints
extension CurrentListViewController {
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            chooseCurrentListButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            chooseCurrentListButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            chooseCurrentListButton.widthAnchor.constraint(equalToConstant: 200),
            chooseCurrentListButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: chooseCurrentListButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        
        
//        NSLayoutConstraint.activate([
//            tapBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
//            tapBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//            tapBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
//            tapBarView.heightAnchor.constraint(equalToConstant: 100)
//        ])
        
//        NSLayoutConstraint.activate([
//            chooseCurrentListButton.centerYAnchor.constraint(equalTo: tapBarView.centerYAnchor),
//            chooseCurrentListButton.trailingAnchor.constraint(equalTo: tapBarView.trailingAnchor, constant: -20),
//            chooseCurrentListButton.widthAnchor.constraint(equalToConstant: 100),
//            chooseCurrentListButton.heightAnchor.constraint(equalToConstant: 40)
//        ])
        
    }

}

// MARK: - TableView Setups
extension CurrentListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentListTableViewCell", for: indexPath) as! CurrentListTableViewCell
        cell.city = cities[indexPath.row]
        
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
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell!.isSelected
                {
            cell!.isSelected = false
            if cell!.accessoryType == UITableViewCell.AccessoryType.none
                    {
                cell!.accessoryType = UITableViewCell.AccessoryType.checkmark
                    }
                    else
                    {
                        cell!.accessoryType = UITableViewCell.AccessoryType.none
                    }
                }
    }
}

extension CurrentListViewController: UpdateCurrentList {
    func updateCityList(list: CityList) {
        currentList = list
        tableView.reloadData()
    }
    
    
}
