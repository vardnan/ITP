//
//  InvestmentView.swift
//  ITP
//
//  Created by Vardnan Sivarajah on 20/04/2020.
//  Copyright © 2020 Vardnan. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

struct Investment {
    var investmentsName: String
}

class InvestmentView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var uid: String?
    var investments: [Investment] = []
    
    
    @IBOutlet weak var investmentsTV: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchItems = [Investment]()
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        investmentsTV.delegate = self
        investmentsTV.dataSource = self
        investmentsTV.rowHeight = 80
        
        loadInvestments()
        
    }
    
    func loadInvestments() {
        
        let ref = Database.database().reference(withPath: "users").child(uid!).child("securities")
        
        ref.observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let investmentsName = child.key
                
                let investmentsRef = ref.child(investmentsName)
                investmentsRef.observeSingleEvent(of: .value) { (investmentsSnapshot) in
                    
                    let value = investmentsSnapshot.value as? NSDictionary
                    self.investments.append(Investment (investmentsName: investmentsName))
                    self.investmentsTV.reloadData()
                }
            }
        }
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchItems.count
        }
        else {
           return investments.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "investmentsCell") as! InvestmentsCell
        
        if searching {
            cell.investmentsLabel.text = searchItems[indexPath.row].investmentsName
        }
        else {
            cell.investmentsLabel.text = investments[indexPath.row].investmentsName
        }
        
        return cell
        
    }
}

extension InvestmentView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let ref = Database.database().reference(withPath: "users").child(uid!).child("securities")

        
        searchItems = investments.filter({$0.investmentsName.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        investmentsTV.reloadData()
    }
}
