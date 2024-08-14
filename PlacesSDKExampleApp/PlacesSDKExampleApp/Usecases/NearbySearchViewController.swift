//
//  NearbySearchViewController.swift
//  OlaMapServicesExample
//
//  Created by Zeeshan Khundmiri on 05/08/24.
//

import UIKit
import OlaMapServices
import CoreLocation

class NearbySearchViewController: BaseViewController {
    
    var nearbyCategories = [
        NearbyCategoryModel(categoryName: "restaurant", isSelected: false),
        NearbyCategoryModel(categoryName: "parking", isSelected: false),
        NearbyCategoryModel(categoryName: "gas_station", isSelected: false),
        NearbyCategoryModel(categoryName: "lodging", isSelected: false),
        NearbyCategoryModel(categoryName: "bank", isSelected: false),
        NearbyCategoryModel(categoryName: "hospital", isSelected: false),
      ]
                        
    lazy var nearbyCategoryCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 10.0
        flowLayout.minimumLineSpacing = 10.0
        flowLayout.sectionInset = .zero
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(NearbyCollectionCell.self, forCellWithReuseIdentifier: String(describing: NearbyCollectionCell.self))
        collection.backgroundColor = .white
        return collection
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.separatorColor = .lightGray
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = 0
        }
        tableView.contentInset = .zero
        tableView.keyboardDismissMode = .onDrag
        tableView.tableHeaderView = nil
        tableView.backgroundColor = .white
        return tableView
    }()
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = "Please select the category."
        label.textColor = .black
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    lazy var titlteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = ""
        label.textColor = .black
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    var nearbyResponse: AutoCompleteResponseModel?
    let olaPlacesService = OlaPlacesService()
    var previousSelectedCategory = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupUI()
    }
    

    private func setupUI() {
        self.view.addSubview(headerLabel)
        self.view.addSubview(nearbyCategoryCollectionView)
        self.view.addSubview(titlteLabel)
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            headerLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            headerLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            nearbyCategoryCollectionView.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 20),
            nearbyCategoryCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            nearbyCategoryCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            nearbyCategoryCollectionView.heightAnchor.constraint(equalToConstant: 200),
            
            titlteLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            titlteLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            titlteLabel.topAnchor.constraint(equalTo: self.nearbyCategoryCollectionView.bottomAnchor, constant: 20),
            
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: self.titlteLabel.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
        ])
    }
    
    func selectedCell(collectionView: UICollectionView, indexPath: IndexPath) {
        if let _ = collectionView.cellForItem(at: indexPath) as? NearbyCollectionCell {
            if previousSelectedCategory != indexPath.row {
                self.nearbyCategories[indexPath.row].isSelected = true
                if previousSelectedCategory >= 0 {
                    self.nearbyCategories[previousSelectedCategory].isSelected = false
                }
                previousSelectedCategory = indexPath.row
            }
            self.nearbyCategoryCollectionView.reloadData()
            
            
        }
    }
}


extension NearbySearchViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nearbyCategories.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: NearbyCollectionCell.self), for: indexPath) as? NearbyCollectionCell else { return UICollectionViewCell() }
        let model = nearbyCategories[indexPath.row]
        cell.setupCell(model: model)
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let categoryName = nearbyCategories[indexPath.row].categoryName
        let location = CLLocationCoordinate2D(latitude: 12.93145226827615, longitude: 77.61645030596725)
        self.showActivityIndicator()
        self.olaPlacesService.nearbyPlaces(categoryName: categoryName, locationCoordinate: location) { [weak self] result in
            DispatchQueue.main.async {
                self?.hideActivityIndicator()
                switch result {
                case .success(let success):
                    if let predictions = success.predictions, predictions.count > 0 {
                        self?.titlteLabel.text = categoryName.capitalized
                        self?.nearbyResponse = success
                       
                        self?.selectedCell(collectionView: collectionView, indexPath: indexPath)
                    }else {
                        self?.showAlert(messgae: "No \(categoryName.capitalized) found")
                    }
                    self?.tableView.reloadData()
                case .failure(let failure):
                    self?.showAlert(messgae: failure.message)
                }
            }
           
        }
        
    }
    
}

extension NearbySearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model = self.nearbyCategories[indexPath.row]
        let width = model.categoryName.width(withConstrainedHeight: 40, font: UIFont.systemFont(ofSize: 18, weight: .medium))
        let imageAndSpaceWidth: CGFloat = 40.0 + 16.0 // + 16 trailing space
        return CGSize(width: imageAndSpaceWidth + width, height: 40)
    }
}


extension NearbySearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nearbyResponse?.predictions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        guard let predictions = nearbyResponse?.predictions else { return UITableViewCell()}
        let prediction = predictions[indexPath.row]
        cell.textLabel?.text = prediction.structuredFormatting?.mainText
        cell.detailTextLabel?.text = prediction.predictionDescription
        
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .black
        cell.detailTextLabel?.textColor = .black
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}

