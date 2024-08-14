//
//  BaseViewController.swift
//  OlaMapServicesExample
//
//  Created by Zeeshan Khundmiri on 02/08/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .black
        activityIndicator.isHidden = true
        return activityIndicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUIActivityIndicator()
    }
    
    func showActivityIndicator() {
        activityIndicator.isHidden = false
        self.view.bringSubviewToFront(activityIndicator)
        self.activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
    }
    
    func hideActivityIndicator() {
        self.activityIndicator.stopAnimating()
        self.view.isUserInteractionEnabled = true
    }
    

    private func setupUIActivityIndicator() {

        self.view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
    }
    
    func showAlert(messgae: String) {
        let alertController = UIAlertController(title: "OlaMap Services", message: "\(messgae). \n Please try again", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            // Handle OK button tap
        }

        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)
    }

}
