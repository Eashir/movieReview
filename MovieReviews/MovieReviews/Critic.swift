//
//  Critic.swift
//  MovieReviews
//
//  Created by Eashir Arafat on 11/4/16.
//  Copyright © 2016 Evan. All rights reserved.
//

import Foundation

enum CriticModelParseError: Error {
    case results(json: Any)
    case name
}

class Critic {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    convenience init?(from dictionary: [String: AnyObject]) throws {
        if let name = dictionary["display_name"] as? String
        {
            self.init(name: name)
        } else {
            throw CriticModelParseError.name
        }
    }
    
    static func critics(from data:Data) -> [Critic]? {
        var criticsToReturn: [Critic]? = []
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let response: [String: AnyObject] = jsonData as? [String: AnyObject],
                let results = response["results"] as? [[String: AnyObject]] else {
                    throw CriticModelParseError.results(json: jsonData)
            }
            
            for criticDict in results {
                if let critic = try Critic(from: criticDict) {
                    criticsToReturn?.append(critic)
                }
            }
        }
        catch let CriticModelParseError.results(json: json) {
            print("Error encountered with parsing 'critic' or 'results' key for object: \(json)")
        }
        catch {
            print("Unknown parsing error")
        }
        
        return criticsToReturn
    }
}
