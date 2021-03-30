//
//  TranslationViewController.swift
//  TravelApp
//
//  Created by Antoine Antoniol on 29/10/2019.
//  Copyright © 2019 Antoine Antoniol. All rights reserved.
//

import UIKit

final class TranslationViewController: UIViewController,UITextViewDelegate {
    
    //  MARK: - Properties
    
    private let translationService = TranslationService()
    
    //  MARK: - Outlets
    
    @IBOutlet private weak var transalteButton: UIButton!
    @IBOutlet var inputTextView: UITextView!
    @IBOutlet var frenchView: UIView!
    @IBOutlet var outputTextView: UITextView!
    @IBOutlet var englishView: UIView!
    @IBOutlet var clearButton: UIButton!
    
   
    //  MARK: - Action
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        inputTextView.text = ""
        outputTextView.text = ""
    }
    
    
    @IBAction private func translateButton(_ sender: UIButton) {
        guard let textInput = inputTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        translationService.getTranslation(input: textInput, callBack: { (success, translateData) in
            if success {
                if self.inputTextView.text != "" {
                        guard let translateData = translateData else { return }
                        self.outputTextView.text = translateData.data.translations[0].translatedText
                }
                else {
                    DispatchQueue.main.async {
                        self.showAlert(alert: .alertInputText)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.showAlert(alert:.alertNetworkMessage)
                }
            }
        })
    }
    
    // MARK: - Methods
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Entrer votre texte en français ici" {
            textView.text = ""
            textView.textColor = #colorLiteral(red: 0.2774488032, green: 0.2916063964, blue: 0.9450252652, alpha: 1)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Entrer votre texte en français ici"
            textView.textColor = #colorLiteral(red: 0.2774488032, green: 0.2916063964, blue: 0.9450252652, alpha: 1)
        }
    }
    
    fileprivate func textView() {
        setUpTextView(textView: inputTextView)
        setUpTextView(textView: outputTextView)
        inputTextView.text = "Entrer votre texte en français ici"
        outputTextView.text = "Il apparaitra en anglais ici!"
        inputTextView.delegate = self
        outputTextView.delegate = self
    }
    
    fileprivate func buttons() {
        setUpButton(button: clearButton)
        setUpButton(button: transalteButton)
    }
    
    fileprivate func views() {
        viewShadow(view: frenchView, cornerRadius: 25)
        viewShadow(view: englishView, cornerRadius: 25)
    }

    // MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        textView()
        views()
        buttons()
        }
 
    }

