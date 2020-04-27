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
    
    var clientID: String?
    
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
    
    @IBAction func ClientToInfo(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ProfileToInfo", sender: uid)
    }
    
    @IBAction func ClientToGoals(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ClientToGoals", sender: uid)
    }
    
    @IBAction func ClientToInvestments(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ClientToInvestments", sender: uid)
    }
    
    
    @IBOutlet weak var riskLabel: UILabel!
    
    @IBAction func riskSlider(_ sender: UISlider) {
        
        riskValue = Int(sender.value)
        riskLabel.text = String(self.numberRisk)
        updateRiskValue()
        
    }
    
    
    @IBOutlet weak var sliderRisk: UISlider!
    
    @IBOutlet weak var clientName: UILabel!
    
    @IBOutlet weak var clientIDLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clientIDLabel.text = "(\(clientID!))"
        
        
        let countRef =  Database.database().reference(withPath: "users").child(self.uid!).child("riskValue")
        
        countRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            let valueRisk = snapshot.value as? Int
            
            self.numberRisk = valueRisk!
            
            self.riskLabel.text = String(self.numberRisk)
            self.sliderRisk.value = Float(self.numberRisk)
            
        }) {(error) in
            print(error.localizedDescription)
        }
        
        let clientNameRef =  Database.database().reference(withPath: "users").child(self.uid!).child("clients").child(clientID!).child("name")
        
        clientNameRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            let clientName = snapshot.value as? String
            
            self.clientName.text = clientName!
            
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
            
        else if segue.identifier == "ProfileToInfo" {
            
            let infoVC = segue.destination as! ClientInfoView
            let uid = sender as! String
            infoVC.uid = uid
            infoVC.clientID = self.clientID
            
        }
            
        else if segue.identifier == "ClientToGoals" {
            
            let goalsVC = segue.destination as! ClientGoalsView
            let uid = sender as! String
            goalsVC.uid = uid
            goalsVC.clientID = self.clientID
        }
            
        else if segue.identifier == "ClientToInvestments" {
            
            let investmentsVC = segue.destination as! InvestmentView
            let uid = sender as! String
            investmentsVC.uid = uid
            investmentsVC.clientID = self.clientID
            
        }
    }
}

