//
//  ViewController.swift
//  MovieReviews
//
//  Created by Eashir Arafat on 11/4/16.
//  Copyright © 2016 Evan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var critics: [Critic] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIRequestManager.manager.getData(endPoint: "https://global.api.pvp.net/api/lol/static-data/na/v1.2/champion?api_key=RGAPI-d738917d-a306-4003-92a0-c00f74a49fab") { (data: Data?) in
            if let validData = data,
                let validCritics = Critic.critics(from: validData) {
                self.critics =  validCritics
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.critics.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "criticCell", for: indexPath)
        cell.textLabel?.text = critics[indexPath.row].name
        // Configure the cell...
        
        return cell
    }
    
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     



}

