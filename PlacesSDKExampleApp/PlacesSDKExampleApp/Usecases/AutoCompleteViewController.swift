//
//  AutoCompleteViewController.swift
//  OlaMapServicesExample
//
//  Created by Zeeshan Khundmiri on 02/08/24.
//

import UIKit

import UIKit
import OlaMapServices

final class AutoCompleteViewController: BaseViewController {
    
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
    
    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)
        ]
        let placeholderText = "Search for a place or address"
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.tintColor = .black
        textField.layer.cornerRadius = 8
        textField.textAlignment = .left
        textField.delegate = self
        textField.textColor = .black
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.text = "Search a place and select to get Place details."
        label.numberOfLines = 0
        return label
    }()
    
    let placeService = OlaPlacesService()
    var searchPlaceResponse: AutoCompleteResponseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupUI()
        
    }
    
    func setupUI() {
    
        self.view.addSubview(searchTextField)
        self.view.addSubview(tableView)
        self.view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: self.searchTextField.bottomAnchor, constant: 16),
            
            searchTextField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 16),
            searchTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            searchTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            searchTextField.heightAnchor.constraint(equalToConstant: 56),
        
        ])
        
    }
    
}

extension AutoCompleteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchPlaceResponse?.predictions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        guard let predictions = searchPlaceResponse?.predictions else { return UITableViewCell()}
        let prediction = predictions[indexPath.row]
        cell.textLabel?.text = prediction.structuredFormatting?.mainText
        cell.detailTextLabel?.text = prediction.predictionDescription
        
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .black
        cell.detailTextLabel?.textColor = .black
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let predictions = searchPlaceResponse?.predictions, let placeId = predictions[indexPath.row].placeID else { return }
        self.showActivityIndicator()
        self.placeService.placeDetails(placeId: placeId) { [weak self] result in
            DispatchQueue.main.async {
                self?.searchTextField.endEditing(true)
                self?.hideActivityIndicator()
                switch result {
                case .success(let success):
                    let placeDetailsVC = PlaceDetailsViewController(model: success)
                    self?.present(placeDetailsVC, animated: true)
                case .failure(let failure):
                    self?.showAlert(messgae: failure.localizedDescription)
                }
            }
            
        }
       
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}

extension AutoCompleteViewController: UITextFieldDelegate {
   
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var text = textField.text ?? ""
        if let textRange = Range(range, in: text) {
            text = text.replacingCharacters(in: textRange, with: string)
        }

        if text.count > 0 {
            placeService.autocomplete(query: text, location: nil) { [weak self] result in
                switch result {
                case .success(let success):
                    
                    DispatchQueue.main.async {
                        self?.searchPlaceResponse = success
                        self?.tableView.reloadData()
                    }
                case .failure(let failure):
                    DispatchQueue.main.async {
                        self?.showAlert(messgae: failure.message)
                    }
                    print("failed to search = \(text)")
                }
            }
            
        } else {
            self.searchPlaceResponse = nil
         
                self.tableView.reloadData()
            
          
        }
        
        return true
    }
    
}




