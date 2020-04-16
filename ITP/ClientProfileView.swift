//
//  ClientProfileView.swift
//  ITP
//
//  Created by Vardnan Sivarajah on 17/03/2020.
//  Copyright © 2020 Vardnan. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ClientProfileView: UIViewController {
    
    var uid: String?
    
    var riskValue = 0
    
    var numberRisk = 0
    
    func updateRiskValue() {
        
        let countRef =  Database.database().reference(withPath: "users").child(self.uid!).child("riskValue")
        
        countRef.setValue(self.riskValue)
        
        countRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            let valueRisk = snapshot.value as? Int
            
            self.numberRisk = valueRisk!
            
            print(valueRisk!)
            
        }) {(error) in
            print(error.localizedDescription)
        }
    }
    
    @IBAction func ClientToKYC(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "ClientToKYC", sender: uid)
    }
    
    @IBOutlet weak var riskLabel: UILabel!
    
    @IBAction func riskSlider(_ sender: UISlider) {
        
        riskValue = Int(sender.value)
        riskLabel.text = String(self.numberRisk)
        updateRiskValue()
        
    }
    
    
    @IBOutlet weak var sliderRisk: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let countRef =  Database.database().reference(withPath: "users").child(self.uid!).child("riskValue")
        
        countRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            let valueRisk = snapshot.value as? Int
            
            self.numberRisk = valueRisk!
            
            self.riskLabel.text = String(self.numberRisk)
            self.sliderRisk.value = Float(self.numberRisk)
            
        }) {(error) in
            print(error.localizedDescription)
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ClientToKYC" {
            
            let kycVC = segue.destination as! KYCView
            let uid = sender as! String
            kycVC.uid = uid
            
        }
    }
}

