//
//  DetailViewController.swift
//  ios_todoList
//
//  Created by chaehee on 2023/02/03.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    
    public var item: ToDoListItem?
    public var deletionHandler: (()->Void)?
    public var modificationHandler: (()->Void)?
    
    private let realm = try! Realm()
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    @IBAction func didTapModify(_ sender: Any) {
        let alret = UIAlertController(title: "Do you want to midify this item?", message: "you cannot undo this action", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let delete = UIAlertAction(title: "Modify this item?", style: .default) { action in
            guard let originalItem = self.item else{
                return
            }
            
            let modifyItem = self.realm.objects(ToDoListItem.self).filter(NSPredicate(format: "text = %@", originalItem.text)).first!
            
            if let text = self.textField.text, !text.isEmpty {
                try! self.realm.write {
                    modifyItem.text = text
                    modifyItem.date = self.datePicker.date
                }
                
                self.modificationHandler?()
                self.navigationController?.popToRootViewController(animated: true)
            }
            else{
                print("Add somthing!")
            }
        }

        alret.addAction(delete)
        alret.addAction(cancel)

        present(alret, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.text = item?.text
        
        datePicker.setDate(item!.date, animated: true)
        datePicker.contentHorizontalAlignment = .center
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action:    #selector(didTapDelete))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func didTapDelete(){
        let alret = UIAlertController(title: "", message: "you cannot undo this action", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let delete = UIAlertAction(title: "Delete this item?", style: .destructive) { action in
            guard let deleteItem = self.item else{
                return
            }
            
            self.realm.beginWrite()
            self.realm.delete(deleteItem)
            try! self.realm.commitWrite()
            
            self.deletionHandler?()
            self.navigationController?.popToRootViewController(animated: true)
        }

        alret.addAction(delete)
        alret.addAction(cancel)

        present(alret, animated: true, completion: nil)
    }
}
