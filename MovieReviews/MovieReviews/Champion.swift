//
//  champion.swift
//  MovieReviews
//
//  Created by Eashir Arafat on 11/4/16.
//  Copyright © 2016 Evan. All rights reserved.
//

import Foundation

enum championModelParseError: Error {
    case results(json: Any)
    case name
}

class champion {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    convenience init?(from dictionary: [String: AnyObject]) throws {
        if let name = dictionary["name"] as? String
        {
            self.init(name: name)
        } else {
            throw championModelParseError.name
        }
    }
    
}
