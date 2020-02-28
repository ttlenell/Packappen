//
//  ItemCell.swift
//  TodoApp
//
//  Created by Thomas Lenell on 2020-02-04.
//  Copyright © 2020 Thomas Lenell. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    var item: Item? {
        didSet {
            textLabel?.text = item?.name

            if item?.isDone == true {
                contentView.layer.borderColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                contentView.layer.borderWidth = 4.0
                contentView.layer.cornerRadius = 20
                
                
            } else if item?.isDone == false {
                
                contentView.layer.borderWidth = 4.0
                contentView.layer.cornerRadius = 20
                contentView.layer.borderColor = #colorLiteral(red: 0.7649499774, green: 0.4034959078, blue: 0.4130340517, alpha: 1)
                
                

            }
            
        }
    }
    
     var suggestions: String? {
        didSet {
            textLabel?.text = suggestions
        }
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backgroundColor = UIColor.clear
        contentView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textLabel?.font = UIFont(name:"Avenir-bold", size:28)

      
        

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
