//
//  Extension.swift
//  TravelApp
//
//  Created by Antoine Antoniol on 24/02/2021.
//  Copyright © 2021 Antoine Antoniol. All rights reserved.
//

import UIKit

//  MARK: - Extension UIViewController

extension UIViewController {
    
    func viewShadow(view:UIView,cornerRadius:CGFloat){
        view.layer.cornerRadius = cornerRadius
        view.layer.shadowOffset = CGSize(width: 10,
                                          height: 10)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.3
        view.layer.shadowColor = #colorLiteral(red: 0.5696820021, green: 0.7030721307, blue: 0.9786365628, alpha: 1)
    }
    
    func setUpTextField(textField:UITextField) {
        textField.layer.cornerRadius = 15
        textField.layer.borderColor = #colorLiteral(red: 1, green: 0.4664789438, blue: 0.4441894293, alpha: 1)
        textField.layer.borderWidth = 1
        textField.tintColor = #colorLiteral(red: 0.2774488032, green: 0.2916063964, blue: 0.9450252652, alpha: 1)
        textField.textColor = #colorLiteral(red: 0.2774488032, green: 0.2916063964, blue: 0.9450252652, alpha: 1)
    }
    
    func setUpTextView(textView:UITextView) {
        textView.layer.cornerRadius = 15
        textView.layer.borderColor = #colorLiteral(red: 1, green: 0.4664789438, blue: 0.4441894293, alpha: 1)
        textView.layer.borderWidth = 1
        textView.tintColor = #colorLiteral(red: 0.2774488032, green: 0.2916063964, blue: 0.9450252652, alpha: 1)
        textView.textColor = #colorLiteral(red: 0.2774488032, green: 0.2916063964, blue: 0.9450252652, alpha: 1)
    }
    
    func setUpButton(button:UIButton) {
        button.setTitleColor(#colorLiteral(red: 1, green: 0.4664789438, blue: 0.4441894293, alpha: 1) ,for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
        button.layer.shadowOffset = CGSize(width: 10, height: 10)
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.6
        button.layer.shadowColor = #colorLiteral(red: 0.5696820021, green: 0.7030721307, blue: 0.9786365628, alpha: 1)
    }
    
    func setUpLabel(label:UILabel){
        label.layer.shadowOffset = CGSize(width: 10, height: 10)
        label.layer.shadowRadius = 2
        label.layer.shadowOpacity = 0.6
        label.layer.shadowColor = #colorLiteral(red: 0.5696820021, green: 0.7030721307, blue: 0.9786365628, alpha: 1)
    }
 }
