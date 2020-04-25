//
//  ClientInfoView.swift
//  ITP
//
//  Created by Vardnan Sivarajah on 17/04/2020.
//  Copyright © 2020 Vardnan. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ClientInfoView: UIViewController {
    
    var uid: String?
    var clientID: String?
    
    var notesOfClient = "..."
    
    var noting = "..."
    
    func updateClientNotes() {
        
        let countRef =  Database.database().reference(withPath: "users").child(self.uid!).child("clients").child(clientID!).child("clientNotes")
        
        self.notesOfClient = clientNotes.text
        
        countRef.setValue(self.notesOfClient)
        
        countRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            let notesClient = snapshot.value as? String
            
            self.noting = notesClient!
            
            print(self.noting)
            
        }) {(error) in
            print(error.localizedDescription)
        }
    }
    
    
    @IBOutlet weak var clientName: UILabel!
    
    @IBOutlet weak var clientIDLabel: UILabel!
    
    @IBOutlet weak var background1: UILabel!
    
    @IBOutlet weak var background2: UILabel!
    
    @IBOutlet weak var domicile: UILabel!
    
    @IBOutlet weak var birthday: UILabel!
    
    @IBOutlet weak var nationality: UILabel!
    
    @IBOutlet weak var reportingLanguage: UILabel!
    
    @IBOutlet weak var reportingCurrency: UILabel!
    
    @IBOutlet weak var sector: UILabel!
    
    @IBOutlet weak var clientNotes: UITextView!
    
    @IBAction func saveNotes(_ sender: Any) {
        updateClientNotes()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clientIDLabel.text = "(\(clientID!))"
        
        let countRef =  Database.database().reference(withPath: "users").child(self.uid!).child("clients").child(clientID!).child("clientNotes")
        
        countRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            let notesClient = snapshot.value as? String
            
            self.noting = notesClient!
            
            self.clientNotes.text = self.noting
            
        }) {(error) in
            print(error.localizedDescription)
        }
        
        let domRef =  Database.database().reference(withPath: "users").child(self.uid!).child("clients").child(clientID!).child("domicile")
        
        domRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            let clientDomicile = snapshot.value as? String
            
            self.domicile.text = clientDomicile!
            
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
        
        let birthdayRef =  Database.database().reference(withPath: "users").child(self.uid!).child("clients").child(clientID!).child("birthday")
        
        birthdayRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            let birthday = snapshot.value as? String
            
            self.birthday.text = birthday!
            
        }) {(error) in
            print(error.localizedDescription)
        }
        
        let nationalityRef =  Database.database().reference(withPath: "users").child(self.uid!).child("clients").child(clientID!).child("nationality")
        
        nationalityRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            let nationality = snapshot.value as? String
            
            self.nationality.text = nationality!
            
        }) {(error) in
            print(error.localizedDescription)
        }
        
        let reportingLanguageRef =  Database.database().reference(withPath: "users").child(self.uid!).child("clients").child(clientID!).child("reportingLanguage")
        
        reportingLanguageRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            let reportingLanguage = snapshot.value as? String
            
            self.reportingLanguage.text = reportingLanguage!
            
        }) {(error) in
            print(error.localizedDescription)
        }
        
        let reportingCurrencyRef =  Database.database().reference(withPath: "users").child(self.uid!).child("clients").child(clientID!).child("reportingCurrency")
        
        reportingCurrencyRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            let reportingCurrency = snapshot.value as? String
            
            self.reportingCurrency.text = reportingCurrency!
            
        }) {(error) in
            print(error.localizedDescription)
        }
        
        let sectorRef =  Database.database().reference(withPath: "users").child(self.uid!).child("clients").child(clientID!).child("sector")
        
        sectorRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            let sector = snapshot.value as? String
            
            self.sector.text = sector!
            
        }) {(error) in
            print(error.localizedDescription)
        }
        
        let background1Ref =  Database.database().reference(withPath: "users").child(self.uid!).child("clients").child(clientID!).child("background1")
             
             background1Ref.observeSingleEvent(of: .value, with: { (snapshot) in
                 
                 let background1 = snapshot.value as? String
                 
                 self.background1.text = background1!
                 
             }) {(error) in
                 print(error.localizedDescription)
             }
        
        let background2Ref =  Database.database().reference(withPath: "users").child(self.uid!).child("clients").child(clientID!).child("background2")
             
             background2Ref.observeSingleEvent(of: .value, with: { (snapshot) in
                 
                 let background2 = snapshot.value as? String
                 
                 self.background2.text = background2!
                 
             }) {(error) in
                 print(error.localizedDescription)
             }
    }
    
}
