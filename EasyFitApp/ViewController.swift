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
extension UIViewController  {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    



    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
        
        
    }
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
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
    
   


    

    override func viewDidLoad() {
        database_ref = Database.database().reference()
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        let facebookLogin = FBSDKLoginButton()
        view.addSubview(facebookLogin)
        facebookLogin.delegate = self
        facebookLogin.frame = CGRect(x: 20, y: 700, width: view.frame.width - 32, height: 40)
  
//        let firebaseAuth = Auth.auth()
//        do {
//            try firebaseAuth.signOut()
//        } catch let signOutError as NSError {
//            createAlert(title: "Error signing out: %@", message: signOutError.localizedDescription)
//        }

    }

//    override func viewDidAppear(_ animated: Bool) {
//        if FBSDKAccessToken.currentAccessTokenIsActive() == true {
//            self.performSegue(withIdentifier: "goHome", sender: self)
//        }
//        
//    }
   
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if let error = error{
            createAlert(title: "error", message: error.localizedDescription)
        }
        else{
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                if let error = error {
                    // ...
                    self.createAlert(title: "error", message: error.localizedDescription)
                    return
                }
                database_ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    if snapshot.hasChild((Auth.auth().currentUser?.uid)!){
                        
                        self.performSegue(withIdentifier: "goHome", sender: self)
                        
                    }else{
                        
                         self.performSegue(withIdentifier: "loginToRegMore", sender: self)
                    }
                    
                    
                })
               
                // User is signed in
                // ...
            }
        }
//        if  let email = FacebookAuthProvider.credential(withAccessToken: <#T##String#>)
//        {
//            Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
//
//
//                if user != nil{
//                    createUserComplete = true
//                    self.performSegue(withIdentifier: "regToRegMore", sender: self)
//
//                }
//                if let error = error {
//                    ViewController().createAlert(title: "Error", message: error.localizedDescription)
//
//                }
//
//
//
//
//
//            }
//        }
//
//
//
//        else{
//            ViewController().createAlert(title: "Error", message: error.localizedDescription)
//        }
//
//        if let error = error{
//            ViewController().createAlert(title: "Error", message: error.localizedDescription);
//
//        }
//        else if result.isCancelled{
//            ViewController().createAlert(title: "Error", message: "Facebook login cancelled")
//        }
//        else{
//            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
//            self.firebaseLogin(credential)
//
//            self.performSegue(withIdentifier: "regToRegMore", sender: self)
//        }
        
    }
//    func firebaseLogin (_ credential: AuthCredential){
//        if let user = Auth.auth().currentUser {
//            user.linkAndRetrieveData(with: credential) { (authResult, error) in
//                s
//                if let error = error {
//                    ViewController().createAlert(title: "Error", message: error.localizedDescription)
//                    return
//                }
//            }
//        }
//        else {
//            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
//
//                if let error = error {
//
//                    ViewController().createAlert(title: "Error", message: error.localizedDescription)
//                    return
//                }
//
//
//
//            }
//
//        }
//    }
    
    func createAlert(title:String , message:String ){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated:true, completion:nil)
            
        }))
        self.present(alert, animated: true, completion: nil)
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

        








