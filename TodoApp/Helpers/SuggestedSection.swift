//
//  SuggestedItem.swift
//  TodoApp
//
//  Created by Thomas Lenell on 2020-02-19.
//  Copyright © 2020 Thomas Lenell. All rights reserved.
//

import Foundation
import UIKit

 struct SuggestionSection {
    var title: String
    var suggestions: [String]
    
    init(title: String, suggestions: [String]) {
        self.title = title
        self.suggestions = suggestions
    }
    
}
