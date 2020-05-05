//
//  KYCView.swift
//  ITP
//
//  Created by Vardnan Sivarajah on 16/03/2020.
//  Copyright © 2020 Vardnan. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

struct Kyc {
    var isChecked: Bool
    var kycName: String
}

class KYCView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var uid: String?
    
    var isCheckedCount = 0
    
    @IBOutlet weak var kycTableView: UITableView!
    
    @IBOutlet weak var kycProgress: UIProgressView!
    
    @IBOutlet weak var kycPercentage: UILabel!
    
    let progress = Progress(totalUnitCount: 8)
    
    var kyc: [Kyc] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kycTableView.delegate = self
        kycTableView.dataSource = self
        kycTableView.rowHeight = 80
        
        kycProgress.transform = kycProgress.transform.scaledBy(x: 1, y: 3)
        
        loadKyc()
    }
    
    /*override func viewWillAppear(_ animated: Bool) {
     super.viewWillAppear(animated)
     animateTable()
     } */
    
    
    func loadKyc() {
        let ref = Database.database().reference(withPath: "users").child(uid!).child("kycitems")
        
        ref.observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let kycName = child.key
                let kycRef = ref.child(kycName)
                
                kycRef.observeSingleEvent(of: .value) { (kycSnapshot) in
                    let value = kycSnapshot.value as? NSDictionary
                    let isChecked = value!["isChecked"] as? Bool
                    self.kyc.append(Kyc(isChecked: isChecked!, kycName: kycName))
                    self.kycTableView.reloadData()
                }
            }
        }
    }
    
    func updateProgress() {
        
        self.progress.completedUnitCount = Int64(isCheckedCount)
        let progressFloat = Float(self.progress.fractionCompleted)
        self.kycProgress.setProgress(progressFloat, animated: true)
        
        DispatchQueue.main.async {
            self.kycPercentage.text = String(Int(self.progress.fractionCompleted*100)) + " %"
        }
    }
    
    func updateIsCheckedCount() {
    
        let countRef =  Database.database().reference(withPath: "users").child(self.uid!).child("isCheckedCount")
        
        countRef.setValue(self.isCheckedCount)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kyc.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "kycCell", for: indexPath) as! KYCCell
        
        cell.kycLabel.text = kyc[indexPath.row].kycName
        
        if kyc[indexPath.row].isChecked {
            
            cell.kycCheckMark.image = UIImage(named: "checkmark.png")
        }
            
        else {
            cell.kycCheckMark.image = nil
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let ref = Database.database().reference(withPath: "users").child(uid!).child("kycitems").child(kyc[indexPath.row].kycName)
        
        
        /*var cui = Database.database().reference(withPath: "users").child(uid!).child("isCheckedCount") */
        
        if kyc[indexPath.row].isChecked {
            kyc[indexPath.row].isChecked = false
            ref.updateChildValues(["isChecked": false])
            
            if isCheckedCount > 0 {
                self.isCheckedCount -= 1
                print(isCheckedCount)
            }
            
        }
            
        else {
            
            kyc[indexPath.row].isChecked = true
            ref.updateChildValues(["isChecked": true])
            
            self.isCheckedCount += 1
            print(isCheckedCount)
            
        }
        
        updateIsCheckedCount()
        updateProgress()
        kycTableView.reloadData()
        
    }
    
    /* func animateTable() {
        kycTableView.reloadData()
        let cells = kycTableView.visibleCells
        let kycTableViewHeight = kycTableView.bounds.size.height
        
        for kycCell in cells {
            kycCell.transform = CGAffineTransform(translationX: 0, y: kycTableViewHeight)
        }
        
        var delayCounter = 0
        for kycCell in cells {
            UIView.animate(withDuration: 1, delay: Double(delayCounter) * 0.01, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: { kycCell.transform = CGAffineTransform.identity }, completion: nil)
            delayCounter += 1
        }
    } */
}




