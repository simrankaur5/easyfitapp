//
//  RegisterViewController.swift
//  EasyFitApp
//
//  Created by Michal Nowak on 25/02/2019.
//  Copyright © 2019 Michal Nowak. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseUI
import FBSDKLoginKit
import FBSDKCoreKit
import FirebaseDatabase

class RegisterViewController: UIViewController{

    
    @IBOutlet weak var registerEmailTextField: UITextField!
    
    @IBOutlet weak var registerPasswordTextField: UITextField!
    
    @IBOutlet weak var registerConfirmPasswordTextField: UITextField!
    
    @IBAction func continuePressed(_ sender: Any) {
        
        if let email = registerEmailTextField.text, let pass = registerPasswordTextField.text,let confirmPass = registerConfirmPasswordTextField.text
        {
           
                if pass == confirmPass {
                    
                    
                    
                    Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
                        
                        
                        if user != nil{
                            self.performSegue(withIdentifier:"regToRegMore", sender: self)
                            
                        }
                        if let error = error {
                            ViewController().createAlert(title: "Error", message: error.localizedDescription)
                            
                        }
                        

                        
                    }
                }
                else{
                    ViewController().createAlert(title: "Error", message: "Your passwords do no match")
                }
                
                

            
            
        }
        else{

                ViewController().createAlert(title: "Error", message: "Please fill in all fields")
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()


        
        // Do any additional setup after loading the view.
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

