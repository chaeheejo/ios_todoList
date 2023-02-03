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
    
    private let realm = try! Realm()
    
    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        itemLabel.text = item?.text
        dateLabel.text = Self.dateFormatter.string(from: item!.date)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action:    #selector(didTapDelete))
    }
    
    @objc func didTapDelete(){
        
        let alret = UIAlertController(title: "", message: "you cannot undo this action", preferredStyle: .actionSheet)
        let yes = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let no = UIAlertAction(title: "Delete this item?", style: .destructive) { action in
            guard let deleteItem = self.item else{
                return
            }
            
            self.realm.beginWrite()
            self.realm.delete(deleteItem)
            try! self.realm.commitWrite()
            
            self.deletionHandler?()
            self.navigationController?.popToRootViewController(animated: true)
        }

        alret.addAction(no)
        alret.addAction(yes)

        present(alret, animated: true, completion: nil)
    
    }
    


}
