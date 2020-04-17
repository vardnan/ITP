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
    
    var notesOfClient = "..."
    
    var noting = "..."
    
    func updateClientNotes() {
        
        let countRef =  Database.database().reference(withPath: "users").child(self.uid!).child("clientNotes")
        
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
    
    @IBOutlet weak var clientNotes: UITextView!
    
    @IBAction func saveNotes(_ sender: Any) {
        updateClientNotes()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let countRef =  Database.database().reference(withPath: "users").child(self.uid!).child("clientNotes")
        
        countRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            let notesClient = snapshot.value as? String
            
            self.noting = notesClient!
            
            self.clientNotes.text = self.noting
            
        }) {(error) in
            print(error.localizedDescription)
        }
    }
    
}
