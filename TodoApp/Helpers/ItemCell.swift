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
                
                backgroundColor = #colorLiteral(red: 0.4747263789, green: 0.7589706779, blue: 0.3847932816, alpha: 1)
            } else if item?.isDone == false {
                
                backgroundColor = UIColor.red
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
        contentView.layer.borderWidth = 2.0
        
      
        

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
