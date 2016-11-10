//
//  APIRequestManager.swift
//  MovieReviews
//
//  Created by Eashir Arafat on 11/4/16.
//  Copyright © 2016 Evan. All rights reserved.
//

import Foundation

class APIRequestManager {
    
    static let manager = APIRequestManager()
    private init() {}
    
    func getData(endPoint: String, callback: @escaping ([champion]?) -> Void) {
        guard let myURL = URL(string: endPoint) else { return }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: myURL) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Session error \(error)")
            }
            guard let validData = data else { return }
            if let champs = self.parseChampions(from: validData) {
                callback(champs)
            } else {
                callback(nil)
            }
            
            
        }.resume()
    }
    
    func parseChampions(from data:Data) -> [champion]? {
        var champions = [champion]()
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let responses: [String: AnyObject] = jsonData as? [String: AnyObject]
                else {
                    throw championModelParseError.results(json: jsonData)
            }
            guard let responseData = responses["data"] as? [[String: AnyObject]] else { return nil }
            for response in responseData {
                if let champion = try champion(from: response) {
                    champions.append(champion)
                }
                
            }
            
        }
        catch let championModelParseError.results(json: json) {
            print("Error encountered with parsing 'champion' or 'results' key for object: \(json)")
        }
        catch {
            print("Unknown parsing error")
        }
        
        return champions
    }

}
