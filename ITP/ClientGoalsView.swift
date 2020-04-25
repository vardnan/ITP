//
//  ClientGoalsView.swift
//  ITP
//
//  Created by Vardnan Sivarajah on 19/04/2020.
//  Copyright © 2020 Vardnan. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

struct Goal {
    var isChecked: Bool
    var goalName: String
}


class ClientGoalsView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var goalsTV: UITableView!
    
    var goals: [Goal] = []
    var uid: String?
    var clientID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalsTV.delegate = self
        goalsTV.dataSource = self
        goalsTV.rowHeight = 80
        loadGoals()
        
    }
    
    
    
    @IBAction func addGoals(_ sender: UIBarButtonItem) {
        
        let goalAlert = UIAlertController(title: "New Goal", message: "Add a new client goal", preferredStyle: .alert)
        
        goalAlert.addTextField()
        
        let addGoalAction = UIAlertAction(title: "Add", style: .default) { (action) in
            let goalText = goalAlert.textFields![0].text
            self.goals.append(Goal(isChecked: false, goalName: goalText!))
            
            
            let ref = Database.database().reference(withPath: "users").child(self.uid!).child("clients").child(self.clientID!).child("clientGoals")
            
            ref.child(goalText!).setValue(["isChecked": false])
            
            self.goalsTV.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        goalAlert.addAction(addGoalAction)
        goalAlert.addAction(cancelAction)
        
        present(goalAlert, animated: true, completion: nil)
    }
    
    func loadGoals() {
        
        
        let ref = Database.database().reference(withPath: "users").child(self.uid!).child("clients").child(clientID!).child("clientGoals")
        
        ref.observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let goalName = child.key
                
                let goalRef = ref.child(goalName)
                
                goalRef.observeSingleEvent(of: .value) { (goalSnapshot) in
                    
                    let value = goalSnapshot.value as? NSDictionary
                    let isChecked = value!["isChecked"] as? Bool
                    self.goals.append(Goal(isChecked: isChecked!, goalName: goalName))
                    self.goalsTV.reloadData()
                }
            }
        }
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as! GoalCell
        
        cell.goalLabel.text = goals[indexPath.row].goalName
        
        if goals[indexPath.row].isChecked {
            cell.checkMarkImage.image = UIImage(named: "checkmark.png")
        }
            
        else {
            cell.checkMarkImage.image = nil
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            let ref = Database.database().reference(withPath: "users").child(uid!).child("clients").child(clientID!).child("clientGoals").child(goals[indexPath.row].goalName)
            
            if goals[indexPath.row].isChecked {
                goals[indexPath.row].isChecked = false
                ref.updateChildValues(["isChecked": false])
                
            }
                
            else {
                goals[indexPath.row].isChecked = true
                ref.updateChildValues(["isChecked": true])
                
            }
        
        
        goalsTV.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            
            let ref = Database.database().reference(withPath: "users").child(uid!).child("clients").child(clientID!).child("clientGoals").child(goals[indexPath.row].goalName)
            
            ref.removeValue()
            goals.remove(at: indexPath.row)
            
            
            goalsTV.reloadData()
        }
    }
    
}
