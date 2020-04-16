//
//  ClientPop.swift
//  ITP
//
//  Created by Vardnan Sivarajah on 07/04/2020.
//  Copyright © 2020 Vardnan. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ClientPop: UIViewController {
    
    var uid: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ClarkLucaPressed(_ sender: UIButton) {
         self.performSegue(withIdentifier: "ClarkLucaToProfile", sender: uid)
    }
    
       
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ClarkLucaToProfile" {
            
            let ClarkLucaProfileVC = segue.destination as! ClientProfileView
            let uid = sender as! String
            ClarkLucaProfileVC.uid = uid
            
        }
    }
}
