//
//  ViewController.swift
//  ITP
//
//  Created by Vardnan Sivarajah on 04/03/2020.
//  Copyright © 2020 Vardnan. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    var uid: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTF.text = ""
        passwordTF.text = ""
        
         //Looks for single or multiple taps.
       let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
            //tap.cancelsTouchesInView = false

            view.addGestureRecognizer(tap)
        }

        //Calls this function when the tap is recognized.
        @objc func dismissKeyboard() {
            //Causes the view (or one of its embedded text fields) to resign the first responder status.
            view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        emailTF.text = ""
        passwordTF.text = ""
    }
    @IBAction func registerAction(_ sender: Any) {
        
        if emailTF.text != nil && passwordTF.text != nil {
            Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!) { (result, error) in
                if error != nil {
                    print("THERE WAS AN ERROR")
                }
                else {
                    self.uid = (result?.user.uid)!
                    let ref = Database.database().reference(withPath: "users").child(self.uid)
                    ref.setValue(["email": self.emailTF.text!, "password": self.passwordTF.text!])
                }
            }
        }
    }

    @IBAction func signInAction(_ sender: Any) {
        
        if emailTF.text != nil && passwordTF.text != nil {
            Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!) { (result, error) in
                if error != nil {
                    print("THERE WAS AN ERROR")
                }
                else {
                    self.uid = (result?.user.uid)!
                    self.performSegue(withIdentifier: "loginToHome", sender: self.uid)
                    
                }
            }
        }
    }
    
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "loginToHome" {
        let navigation = segue.destination as! UINavigationController
        let homeVC = navigation.topViewController as! HomeScreen_ViewController
        let uid = sender as! String
        homeVC.uid = uid
    }
    
   /* else if segue.identifier == "HomeToTaskList" {
        
        let navigation = segue.destination as! UINavigationController
        let todoVC = navigation.topViewController as! TodoView
        todoVC.userID = uid

    } */
        
        /*let navigation = segue.destination as! UINavigationController
        let todoVC = navigation.topViewController as! TodoView
        todoVC.userID = uid */
    }
}
