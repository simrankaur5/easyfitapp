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
import FirebaseDatabase
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
    
    @IBAction func continuePressed(_ sender: Any) {
        if  let email = registerEmailTextField.text, let pass = registerPasswordTextField.text, let confirmPass = registerConfirmPasswordTextField.text
        {
            if pass == confirmPass{
                
                
                
                Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
                    
                    
                    if user != nil{

                        self.performSegue(withIdentifier: "regToRegMore", sender: self)
                        
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
        database_ref = Database.database().reference()
        super.viewDidLoad()

        let facebookLogin = FBSDKLoginButton()
        view.addSubview(facebookLogin)
        facebookLogin.delegate = self
        facebookLogin.frame = CGRect(x: 20, y: 700, width: view.frame.width - 32, height: 40)
     
        
        
    

    }

//    override func viewDidAppear(_ animated: Bool) {
//        if FBSDKAccessToken.currentAccessTokenIsActive() == true {
//            self.performSegue(withIdentifier: "goHome", sender: self)
//        }
//        
//    }
   

    
    func createAlert(title:String , message:String ){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated:true, completion:nil)
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func firebaseLogin (_ credential: AuthCredential){
        if let user = Auth.auth().currentUser {
            
            user.linkAndRetrieveData(with: credential) { (authResult, error) in
                
                    if let error = error {
                        self.createAlert(title: "Error", message: error.localizedDescription)
                        return
                    }
            }
        }
        else {
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                
                    if let error = error {
                        
                        self.createAlert(title: "Error", message: error.localizedDescription)
                        return
                    }

                

            }

        }
    }
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if let error = error{
                            self.createAlert(title: "Error", message: error.localizedDescription)

        }
        else if result.isCancelled{
            self.createAlert(title: "Error", message: "Facebook login cancelled")
        }
        else{
            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
//            let user = Auth.auth().currentUser
            self.firebaseLogin(credential)
            if let user = Auth.auth().currentUser{
            database_ref.child("users").child((user.uid)).setValue(["username": user.email])
            }
            self.performSegue(withIdentifier: "goHome", sender: self)
        }
        
////        var loginSucess = false;
//        let loginManager = FBSDKLoginManager()
//        loginManager.logIn(withReadPermissions: ["email"], from: self, handler: { (result, error) in
//
//            if let error = error {
//                self.createAlert(title: "Error", message: error.localizedDescription)
//            } else if result!.isCancelled {
//                self.createAlert(title: "Error", message: "Facebook login cancelled")
//                print("FBLogin cancelled")
//            } else {
//                // [START headless_facebook_auth
//
//                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
//
//                self.firebaseLogin(credential)
//                                        self.performSegue(withIdentifier: "goHome", sender: self)
//
//
//                // [END headless_facebook_auth]
////                Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
//
//            }
//
//        })
//        if loginSucess == true{
//                        let credential = FacebookAuthProvider.credential(withAccessToken: ((FBSDKAccessToken.current().tokenString))!)
//                        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
//                        self.performSegue(withIdentifier: "goHome", sender: self)
//        }

//            let credential = FacebookAuthProvider.credential(withAccessToken: ((FBSDKAccessToken.current().tokenString))!)
//            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
//            self.performSegue(withIdentifier: "goHome", sender: self)
        
        
    }

        


    //    @IBAction func registerPressed(_ sender: Any) {
    //        if  let email = registerEmailTextField.text, let pass = registerPasswordTextField.text, let confirmPass = registerConfirmPasswordTextField.text
    //        {
    //            if pass == confirmPass{
    //
    //
    //
    //                Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
    //
    //
    //                    if user != nil{
    //
    //                        self.performSegue(withIdentifier: "regToRegMore", sender: self)
    //
    //                    }
    //                    if let error = error {
    //                        self.createAlert(title: "Error", message: error.localizedDescription)
    //
    //                    }
    //
    //
    //
    //
    //
    //                }
    //            }
    //            else{
    //                createAlert(title: "Error", message: "Your passwords do no match")
    //            }
    //        }
    //
    //
    //    }

}


