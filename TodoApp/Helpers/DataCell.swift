//
//  ItemCell.swift
//  TodoApp
//
//  Created by Thomas Lenell on 2020-02-04.
//  Copyright © 2020 Thomas Lenell. All rights reserved.
//

import UIKit

class DataCell: UITableViewCell {
    
    var trip: Trip? {
        didSet {
            textLabel?.text = trip?.name
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        textLabel?.font = UIFont(name:"Avenir", size:30)
        backgroundColor = UIColor.clear
        contentView.layer.borderWidth = 4.0
        contentView.layer.cornerRadius = 20
        

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
