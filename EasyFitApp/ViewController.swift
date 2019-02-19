//
//  ViewController.swift
//  EasyFitApp
//
//  Created by Michal Nowak on 15/02/2019.
//  Copyright © 2019 Michal Nowak. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseUI
import FBSDKLoginKit
import FBSDKCoreKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    


    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
        
        
    }

    @IBAction func loginPressed(_ sender: Any) {
        if let email = emailTextField.text, let pass = passwordTextField.text
        {
            Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
                if user != nil{
                    // user found go home screen
                    self.performSegue(withIdentifier:
                        "goHome", sender: self)
                }
                if let error = error{
                    self.createAlert(title: "Error", message: error.localizedDescription)
                    
                }
                
            }
            
        }
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        if  let email = registerEmailTextField.text, let pass = registerPasswordTextField.text, let confirmPass = registerConfirmPasswordTextField.text
        {
            if pass == confirmPass{
                
                
                
                Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
                    
                    
                    if user != nil{
                        
                        self.performSegue(withIdentifier: "regToLogin", sender: self)
                        
                    }
                    if let error = error {
                        self.createAlert(title: "Error", message: error.localizedDescription)
                        
                    }
                    
                    
                    
                    
                    
                }
            }
            else{
                createAlert(title: "Error", message: "Your passwords do no match")
            }
        }
        
        
    }
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var registerEmailTextField: UITextField!
    
    @IBOutlet weak var registerPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerConfirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let facebookLogin = FBSDKLoginButton()
        view.addSubview(facebookLogin)
        facebookLogin.delegate = self
//        facebookLogin.center = self.view.center
        facebookLogin.frame = CGRect(x: 20, y: 700, width: view.frame.width - 32, height: 40)
        
     
        
        
    

    }
    
    func createAlert(title:String , message:String ){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated:true, completion:nil)
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func firebaseLogin (_ credential: AuthCredential){
        if let user = Auth.auth().currentUser {
            // [START link_credential]
            user.linkAndRetrieveData(with: credential) { (authResult, error) in
                // [START_EXCLUDE]
                
                    if let error = error {
                        self.createAlert(title: "Error", message: error.localizedDescription)
                        return
                    }
                    else{
                    
                
                   self.performSegue(withIdentifier: "goHome", sender: self)
                }
                // [END_EXCLUDE]
            }
            // [END link_credential]
        }
        else {
            // [START signin_credential]
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                // [START_EXCLUDE silent]
                
                    // [END_EXCLUDE]
                    if let error = error {
                        // [START_EXCLUDE]
                        self.createAlert(title: "Error", message: error.localizedDescription)
                        // [END_EXCLUDE]
                        return
                    }
                    else{
                           self.performSegue(withIdentifier: "goHome", sender: self)
                }
                    // User is signed in
                    // [START_EXCLUDE]
                    // Merge prevUser and currentUser accounts and data
                    // ...
                    // [END_EXCLUDE]
                    // [START_EXCLUDE silent]
                
                // [END_EXCLUDE]
            }
            // [END signin_credential]
        }
    }
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
//        if let error = error {
//            self.createAlert(title: "Error", message: error.localizedDescription)
//        }
        let loginManager = FBSDKLoginManager()
        loginManager.logIn(withReadPermissions: ["email"], from: self, handler: { (result, error) in
            if let error = error {
                self.createAlert(title: "Error", message: error.localizedDescription)
            } else if result!.isCancelled {
                print("FBLogin cancelled")
            } else {
                // [START headless_facebook_auth]
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseLogin(credential)
             
         
                // [END headless_facebook_auth]
//                Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
               
            }
        })

//            let credential = FacebookAuthProvider.credential(withAccessToken: ((FBSDKAccessToken.current().tokenString))!)
//            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
//            self.performSegue(withIdentifier: "goHome", sender: self)
            
        
    }

        


}

class homeViewController: UIViewController{
    
}

