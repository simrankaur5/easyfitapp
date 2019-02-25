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
class RegisterViewController: UIViewController, FBSDKLoginButtonDelegate{

    
    @IBOutlet weak var registerEmailTextField: UITextField!
    
    @IBOutlet weak var registerPasswordTextField: UITextField!
    
    @IBOutlet weak var registerConfirmPasswordTextField: UITextField!
    
    @IBAction func continuePressed(_ sender: Any) {
        if  let email = registerEmailTextField.text, let pass = registerPasswordTextField.text, let confirmPass = registerConfirmPasswordTextField.text
        {
            if pass == confirmPass{
                
                
                
                Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
                    
                    
                    if user != nil{
                        
                        self.performSegue(withIdentifier: "regToRegMore", sender: self)
                        
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
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let facebookLogin = FBSDKLoginButton()
        view.addSubview(facebookLogin)
        facebookLogin.delegate = self
        facebookLogin.frame = CGRect(x: 20, y: 700, width: view.frame.width - 32, height: 40)
        
        
        
        // Do any additional setup after loading the view.
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
        
        
    }
    func firebaseLogin (_ credential: AuthCredential){
        if let user = Auth.auth().currentUser {
            user.linkAndRetrieveData(with: credential) { (authResult, error) in
                
                if let error = error {
                    ViewController().createAlert(title: "Error", message: error.localizedDescription)
                    return
                }
            }
        }
        else {
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                
                if let error = error {
                    
                    ViewController().createAlert(title: "Error", message: error.localizedDescription)
                    return
                }
                
                
                
            }
            
        }
    }
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if let error = error{
            ViewController().createAlert(title: "Error", message: error.localizedDescription);#imageLiteral(resourceName: "exercising-clipart-ladies-fitness-5.png")
            
        }
        else if result.isCancelled{
            ViewController().createAlert(title: "Error", message: "Facebook login cancelled")
        }
        else{
            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            self.firebaseLogin(credential)
                        if let user = Auth.auth().currentUser{
                        database_ref.child("users").child((user.uid)).setValue(["username": user.email])
                        }
            self.performSegue(withIdentifier: "regToRegMore", sender: self)
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
}
