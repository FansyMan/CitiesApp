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
        tableView.isUserInteractionEnabled = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var currentList: CityList?
    var cities: [City] = []
    var service: ListService!
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Cities"
        
        setupViews()
        setConstraints()
        setupDelegates()
        service = ListService()
        
        
        
        let longpress = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureRecognized(gestureRecognizer:)))
            self.tableView.addGestureRecognizer(longpress)
    }
    
    // MARK: - View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let allLists = service.getKists()
        currentList = allLists[2]
        let listTitle = currentList?.shortName
        title = listTitle
        guard let currentList = currentList else { return }
        cities = currentList.cities!
        tableView.reloadData()
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.addSubview(tableView)
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
}

// MARK: - Constraints
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

// MARK: - TableView Setups
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
