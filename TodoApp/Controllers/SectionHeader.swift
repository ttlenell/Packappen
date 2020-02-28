//
//  SectionHeader.swift
//  TodoApp
//
//  Created by Thomas Lenell on 2020-02-04.
//  Copyright © 2020 Thomas Lenell. All rights reserved.
//

import UIKit

class SectionHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var sectionTitle: UILabel!
    
    
    func setTitle(title: String) {
        
        sectionTitle.text = title
        
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
