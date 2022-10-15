//
//  TweetViewController.swift
//  Twitter
//
//  Created by Pride Mbabit on 10/11/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController{

    @IBOutlet weak var tweetTextView: UITextView!
    
    @IBAction func tweet(_ sender: Any) {
        if(!tweetTextView.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true,completion: nil)
            }, failure: {(error)in print("Error posting tweet \(error)")
                self.dismiss(animated: true,completion: nil)
            })
        }else{
            self.dismiss(animated: true,completion: nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

     func setSelected(_ selected: Bool, animated: Bool) {
//        \

        // Configure the view for the selected state
    }

}
