//
//  PlaceDetailsViewController.swift
//  OlaMapServicesExample
//
//  Created by Zeeshan Khundmiri on 02/08/24.
//

import UIKit
import OlaMapServices

class PlaceDetailsViewController: UIViewController {
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = "Name: \(placeDetailsModel.result?.name ?? "")"
        label.textColor = .black
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font =  UIFont.systemFont(ofSize: 16)
        label.text = "Address: \(placeDetailsModel.result?.formattedAddress ?? "")"
        label.textColor = .black
        return label
    }()
    
    lazy var coordinatesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font =  UIFont.systemFont(ofSize: 16)
        let location = placeDetailsModel.result?.geometry?.location
        label.text = "Coordinates: \(location?.latitude ?? 0.0),\(location?.longitude ?? 0.0)"
        label.textColor = .black
        return label
    }()
    
    lazy var iconImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "placeholder")
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    lazy var iconImageViewBackground: UIView = {
       let background = UIView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.backgroundColor = .lightGray
        background.addSubview(iconImageView)
        return background
    }()
    
    private var placeDetailsModel: PlaceDetailsResponseModel
    
    init(model: PlaceDetailsResponseModel) {
        self.placeDetailsModel = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        setupUI()
        setupIcon()
    }
    
    private func setupUI() {
        self.view.addSubview(nameLabel)
        self.view.addSubview(addressLabel)
        self.view.addSubview(coordinatesLabel)
        self.view.addSubview(iconImageViewBackground)
        self.view.addSubview(iconImageView)
       
        
        NSLayoutConstraint.activate([
            
            nameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            nameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            iconImageViewBackground.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 20),
            iconImageViewBackground.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            iconImageViewBackground.widthAnchor.constraint(equalToConstant: 170),
            iconImageViewBackground.heightAnchor.constraint(equalToConstant: 170),
            
            iconImageView.leadingAnchor.constraint(equalTo: iconImageViewBackground.leadingAnchor, constant: 10),
            iconImageView.topAnchor.constraint(equalTo: iconImageViewBackground.topAnchor, constant: 10),
            iconImageView.widthAnchor.constraint(equalToConstant: 150),
            iconImageView.heightAnchor.constraint(equalToConstant: 150),
            
            addressLabel.topAnchor.constraint(equalTo: self.iconImageViewBackground.bottomAnchor, constant: 30),
            addressLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            addressLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            
            coordinatesLabel.topAnchor.constraint(equalTo: self.addressLabel.bottomAnchor, constant: 30),
            coordinatesLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            coordinatesLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),

        ])
    }
    
    func setupIcon() {
        if let urlString = placeDetailsModel.result?.iconMaskBaseURI, let url = URL(string: urlString) {
            DispatchQueue.global().async { [weak self] in
                 guard let imageData = try? Data(contentsOf: url) else {
                  print("Could not get image")
                  return
                }
                
                DispatchQueue.main.async {
                    self?.iconImageView.image = UIImage(data: imageData)

                  
                }
            }
        }
        
        if let backgroundColor = placeDetailsModel.result?.iconBackgroundColor, !backgroundColor.isEmpty {
            iconImageView.backgroundColor = UIColor(hexString: backgroundColor)
            iconImageViewBackground.backgroundColor = UIColor(hexString: backgroundColor)
        }
    }

}
