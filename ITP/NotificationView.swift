//
//  NotificationView.swift
//  ITP
//
//  Created by Vardnan Sivarajah on 10/04/2020.
//  Copyright © 2020 Vardnan. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class NotificationView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    struct Notification {
        var isChecked: Bool
        var notificationName: String
    }
    
    @IBOutlet weak var notificationTV: UITableView!
    
    
    var notifications: [Notification] = []
    
    var uid: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationTV.delegate = self
        notificationTV.dataSource = self
        notificationTV.rowHeight = 80
        
        loadNotifications()
        
    }
    
    func loadNotifications() {
        let ref = Database.database().reference(withPath: "users").child(uid!).child("notifications")
        
        ref.observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                
                let notificationName = child.key
                
                let notificationRef = ref.child(notificationName)
                
                notificationRef.observeSingleEvent(of: .value) { (notificationSnapshot) in
                    let value = notificationSnapshot.value as? NSDictionary
                    let isChecked = value!["isChecked"] as? Bool
                    self.notifications.append(Notification(isChecked: isChecked!, notificationName: notificationName))
                    self.notificationTV.reloadData()
                }
            }
        }
    }
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath) as! NotificationCell
        
        cell.notificationLabel.text = notifications[indexPath.row].notificationName
        
        if notifications[indexPath.row].isChecked {
            cell.prioritisation.image = UIImage(named: "notificationRed.png")
        }
            
        else {
            cell.prioritisation.image = UIImage(named: "notificationGrey.png")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let ref = Database.database().reference(withPath: "users").child(uid!).child("notifications").child(notifications[indexPath.row].notificationName)
        
        if notifications[indexPath.row].isChecked {
            notifications[indexPath.row].isChecked = false
            ref.updateChildValues(["isChecked": false])
        }
            
        else {
            notifications[indexPath.row].isChecked = true
            ref.updateChildValues(["isChecked": true])
            
        }
        
        notificationTV.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let ref = Database.database().reference(withPath: "users").child(uid!).child("notifications").child(notifications[indexPath.row].notificationName)
            
            ref.removeValue()
            notifications.remove(at: indexPath.row)
            notificationTV.reloadData()
            
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        notifications.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    
    
    @IBAction func didTapSort() {
        if notificationTV.isEditing {
            notificationTV.isEditing = false
        }
            
        else {
            notificationTV.isEditing = true
        }
    }
}
