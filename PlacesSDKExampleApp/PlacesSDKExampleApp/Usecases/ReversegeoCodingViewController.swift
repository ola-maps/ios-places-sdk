//
//  ReversegeoCodingViewController.swift
//  OlaMapServicesExample
//
//  Created by Zeeshan Khundmiri on 02/08/24.
//

import UIKit

class ReversegeoCodingViewController: BaseViewController {

    lazy var latitudeTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)
        ]
        let placeholderText = "Enter latitude"
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.tintColor = .black
        textField.layer.cornerRadius = 8
        textField.textAlignment = .left
        textField.textColor = .black
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.keyboardType = .decimalPad
        textField.text = "12.93145226827615"
        return textField
    }()
    
    lazy var longituteTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)
        ]
        let placeholderText = "Enter longitude"
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.tintColor = .black
        textField.layer.cornerRadius = 8
        textField.textAlignment = .left
        textField.textColor = .black
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.keyboardType = .decimalPad
        textField.text = "77.61645030596725"
        return textField
    }()
    
    lazy var latitudeteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = "Latitude"
        label.textColor = .black
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    lazy var longituteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = "Logitude"
        label.textColor = .black
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    private lazy var getResponseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Get Response", for: .normal)
        button.addTarget(self, action: #selector(getReverseGeocodeResponse), for: .touchUpInside)
        button.backgroundColor = .black
        button.titleLabel?.textColor = .white
        return button
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = ""
        label.textColor = .black
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    lazy var responseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = ""
        label.textColor = .black
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font =  UIFont.systemFont(ofSize: 16)
        label.text = ""
        label.textColor = .black
        return label
    }()

    let placeService = OlaPlacesService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.latitudeTextField.becomeFirstResponder()
    }
    
    func setupUI() {
    
        self.view.addSubview(latitudeTextField)
        self.view.addSubview(longituteTextField)
        self.view.addSubview(latitudeteLabel)
        self.view.addSubview(longituteLabel)
        self.view.addSubview(getResponseButton)
        self.view.addSubview(nameLabel)
        self.view.addSubview(addressLabel)
        
        NSLayoutConstraint.activate([
            
            latitudeteLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            latitudeteLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            latitudeteLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            latitudeTextField.topAnchor.constraint(equalTo: self.latitudeteLabel.bottomAnchor, constant: 10),
            latitudeTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            latitudeTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            latitudeTextField.heightAnchor.constraint(equalToConstant: 56),
            
            longituteLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            longituteLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            longituteLabel.topAnchor.constraint(equalTo: self.latitudeTextField.bottomAnchor, constant: 40),
            
            longituteTextField.topAnchor.constraint(equalTo: self.longituteLabel.bottomAnchor, constant: 10),
            longituteTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            longituteTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            longituteTextField.heightAnchor.constraint(equalToConstant: 56),
            
            getResponseButton.topAnchor.constraint(equalTo: self.longituteTextField.bottomAnchor, constant: 40),
            getResponseButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            getResponseButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            getResponseButton.heightAnchor.constraint(equalToConstant: 56),
            
            nameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            nameLabel.topAnchor.constraint(equalTo: self.getResponseButton.bottomAnchor, constant: 40),
            
            addressLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 30),
            addressLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            addressLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            
            

        ])
        
    }
    

    @objc func getReverseGeocodeResponse() {
        guard let lat = latitudeTextField.text, !lat.isEmpty, let lng = longituteTextField.text, !lng.isEmpty else {
            self.showAlert(messgae: "Please enter the latitude and longitude")
            return
        }
        self.view.endEditing(true)
        self.showActivityIndicator()
        self.placeService.reverseGeocode(latlng: "\(lat),\(lng)") { [weak self] result in
            DispatchQueue.main.async {
                self?.hideActivityIndicator()
                switch result {
                case .success(let success):
                    print("=== \(success)")
                    self?.nameLabel.text = success.results?.first?.name
                    self?.addressLabel.text = success.results?.first?.formattedAddress
                case .failure(let failure):
                    print("failure = \(failure)")
                    self?.showAlert(messgae: failure.message)
                }
            }
            
        }
    }
    

}
