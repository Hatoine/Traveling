//
//  ExtensionViewController.swift
//  TravelApp
//
//  Created by Antoine Antoniol on 23/10/2019.
//  Copyright © 2019 Antoine Antoniol. All rights reserved.
//

import UIKit

//  MARK: - Alert

extension UIViewController  {
    /// Show alert with custom message
    func showAlert(alert: AlertMessages) {
        let alertVC = UIAlertController(title: "ERROR", message: alert.rawValue , preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion:nil)
    }
    
    func textFieldShouldReturn(textField: UITextField)->Bool{
        textField.resignFirstResponder()
        return true
    }
}
