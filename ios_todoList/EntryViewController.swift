//
//  EntryViewController.swift
//  ios_todoList
//
//  Created by chaehee on 2023/02/03.
//

import UIKit
import RealmSwift

class EntryViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var dataPicker: UIDatePicker!
    
    private let ream = try! Realm()
    private var completionHandler: (()->Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        textField.becomeFirstResponder()
        textField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func didTapSaveButton(){
        
    }

}
