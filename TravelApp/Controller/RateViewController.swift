//
//  RateViewController.swift
//  TravelApp
//
//  Created by Antoine Antoniol on 13/09/2019.
//  Copyright © 2019 Antoine Antoniol. All rights reserved.
//

import UIKit
import Reachability

final class RateViewController: UIViewController {
    
    //  MARK: - Properties
    
    private let exchangeService  = ExchangeService()
    private var dataPicker = [String:String]()
    private var activeCurrencyChoice = String()
    private lazy var result = self.dataPicker.map{$0.key}.sorted()
    private let reachability = try! Reachability()

    
    //  MARK: - Outlets
    
    @IBOutlet private weak var symbolsPickerView: UIPickerView!
    @IBOutlet private weak var currenciesInput: UITextField!
    @IBOutlet private weak var euroConversion: UITextField!
    @IBOutlet private weak var convertButton: UIButton!
    @IBOutlet var euroView: UIView!
    @IBOutlet var convertView: UIView!
    @IBOutlet var symbolsView: UIView!
    
    
    
    //  MARK: - Action
    
    @IBAction private func symbols(_ sender: UIButton) {
        exchangeService.getRates(devise: activeCurrencyChoice, callBack: { (success, rates) in
            if success {
                guard let rates = rates else { return }
                let rate = rates.rates[self.activeCurrencyChoice]
                guard let actualRate = rate else { return }
                
                if self.currenciesInput.text != "" {
                    guard let currencie = self.currenciesInput.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
                    guard let currencies = Double(currencie) else { return }
                    self.euroConversion.text = String(Int(currencies * actualRate))
                }
                else {
                    DispatchQueue.main.async {
                        self.showAlert(alert: .alertInputNumber)
                    }
                }
            }
            else {
                DispatchQueue.main.async {
                    self.showAlert(alert: .alertNetworkMessage)
                }
            }
        })
    }
    
    // MARK: - Methods
    
    fileprivate func setUpPickerView() {
        symbolsPickerView.setValue(UIColor.white, forKeyPath: "textColor")
        symbolsPickerView.layer.cornerRadius = 20
        symbolsPickerView.layer.masksToBounds = true
    }
   
    
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        switch reachability.connection {
        case .wifi:
            print("Wifi Connection")
        case .cellular:
            print("Cellular Connection")
        case .unavailable:
            print("No Connection")
            DispatchQueue.main.async {
                self.showAlert(alert: .alertNetworkMessage)
            }
        case .none:
            print("No Connection")
        }
    }
        
    // MARK: - viewWillAppear

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
           do {
               try reachability.startNotifier()
           } catch {
               print("Unable to start notifier")
           }
       
        exchangeService.getSymbols { (success, symbols) in
            if success {
                    guard let symbols = symbols else { return }
                    self.dataPicker = symbols.symbols
                    self.symbolsPickerView.reloadAllComponents()
            }
        }
    }

    // MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        viewShadow(view: convertView, cornerRadius: 25)
        viewShadow(view: euroView, cornerRadius: 15)
        viewShadow(view: symbolsView, cornerRadius: 30)
        setUpTextField(textField: currenciesInput)
        setUpTextField(textField: euroConversion)
        setUpButton(button: convertButton)
        setUpPickerView()
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - viewDidDisappear
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
}

    //  MARK: - Picker

extension RateViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataPicker.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return result[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        activeCurrencyChoice = result[row]
    }
}

















