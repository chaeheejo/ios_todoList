//
//  customTableViewCell.swift
//  ios_todoList
//
//  Created by chaehee on 2023/02/09.
//

import UIKit

class customTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var tagName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
