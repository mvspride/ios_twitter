//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Pride Mbabit on 10/3/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit
import AlamofireImage


class HomeTableViewController: UITableViewController {
    
    var tweetArray = [NSDictionary]()
    var numOfTweet: Int!
    
    
    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true,completion: nil)
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
        
    }
    
    func loadTweet(){
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count": 10]

        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: {(tweets: [NSDictionary]) in

            self.tweetArray.removeAll()

            for tweet in tweets {
                self.tweetArray.append(tweet)
            }

            self.tableView.reloadData()

        }, failure: { (Error) in
            print("could not retreive tweets",Error)

        })

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCell
        
        cell.userNameLabel.text = "my name"
        cell.tweetContentLabel.text = "actual tweet"
        let profileImageUrl = URL(string: "data:image/jpeg;base64,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")
        cell.profileImage.af_setImage(withURL: profileImageUrl!)
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        loadTweet()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
