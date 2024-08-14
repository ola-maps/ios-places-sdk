//
//  ViewController.swift
//  OlaMapServicesExample
//
//  Created by Zeeshan Khundmiri on 02/08/24.
//

import UIKit
import OlaMapServices
import CoreLocation

class ViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorColor = .lightGray
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = 0
        }
        tableView.contentInset = .zero
        tableView.tableHeaderView = nil
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    var tableViewDataSource = ["Autocomplete + Place details", "Reversegeocoding", "Nearby Search", "Forward Geocode", "Text Search"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
        ])
    }


}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableViewDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        cell.backgroundColor = .clear
        cell.textLabel?.text = tableViewDataSource[indexPath.row]
        cell.textLabel?.textColor = .black
        cell.textLabel?.textAlignment = .left
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            // AutoComplete + Place details
            let vc = AutoCompleteViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            // Reverse geocode
            let vc = ReversegeoCodingViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            // Nearby search
            let vc = NearbySearchViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            // Forward geocode
            let vc = ForwaredGeocodeViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 4:
            // Text Search
            let vc = TextSearchViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break;
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    
    
}
