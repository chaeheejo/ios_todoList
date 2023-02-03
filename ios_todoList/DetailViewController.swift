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
        guard let deleteItem = self.item else{
            return
        }
        
        realm.beginWrite()
        realm.delete(deleteItem)
        try! realm.commitWrite()
        
        deletionHandler?()
        navigationController?.popToRootViewController(animated: true)
    }
    


}
