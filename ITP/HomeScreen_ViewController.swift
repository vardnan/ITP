//
//  HomeScreen_ViewController.swift
//  ITP
//
//  Created by Vardnan Sivarajah on 14/03/2020.
//  Copyright © 2020 Vardnan. All rights reserved.
//

import UIKit

class HomeScreen_ViewController: UIViewController {
    
    var uid: String?
    
    @IBAction func TaskButtonPressed(_ sender: Any) {
        print(uid!)
        self.performSegue(withIdentifier: "HomeToTaskList", sender: uid)
    }
    
    @IBAction func ClientButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "HomeToClientPop", sender: uid)
    }
    
    @IBAction func MarketButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "HomeToMarket", sender: uid)
        
    }
    
    @IBAction func NotificationButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "HomeToNotification", sender: uid)
        
    }
    
    @IBAction func settingsPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "HomeToSettings", sender: uid)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "HomeToTaskList" {
            
            let todoVC = segue.destination as! TodoView
            let uid = sender as! String
            todoVC.userID = uid
            
        }
            
        else if segue.identifier == "HomeToClientPop" {
            
            let clientPopVC = segue.destination as! ClientPop
            let uid = sender as! String
            clientPopVC.uid = uid
            
        }
            
        else if segue.identifier == "HomeToNotification" {
            
            let notificationVC = segue.destination as! NotificationView
            let uid = sender as! String
            notificationVC.uid = uid
            
        }
        
        else if segue.identifier == "HomeToSettings" {
        
        let settingsVC = segue.destination as! SettingsView
        let uid = sender as! String
        settingsVC.uid = uid
        }
    }
}
