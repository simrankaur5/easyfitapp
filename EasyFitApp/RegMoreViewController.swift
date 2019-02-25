//
//  RegMoreViewController.swift
//  EasyFitApp
//
//  Created by Michal Nowak on 25/02/2019.
//  Copyright © 2019 Michal Nowak. All rights reserved.
//
import UIKit
import FirebaseDatabase
import Firebase
import FirebaseUI
import FBSDKLoginKit
import FBSDKCoreKit
import UIKit

class RegMoreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBAction func registerPressed(_ sender: Any) {
        if let height = heightTextField.text, let gender = genderTextField.text , let weight = weightTextField.text {
            if let user = Auth.auth().currentUser {
                
                database_ref.child("users/\(user.uid)/weight").setValue(weight)
                database_ref.child("users/\(user.uid)/height").setValue(height)
                database_ref.child("users/\(user.uid)/gender").setValue(gender)
                
            }
            self.performSegue(withIdentifier: "regMoreToLogin", sender: self)
        }
        else{
            ViewController().createAlert(title: "error",message: "Please fill in all the fields")
                    }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
