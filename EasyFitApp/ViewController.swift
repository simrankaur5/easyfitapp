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
        
     
        
        
    
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    func createAlert(title:String , message:String ){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated:true, completion:nil)
            
        }))
        self.present(alert, animated: true, completion: nil)
    }

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if let error = error {
            self.createAlert(title: "Error", message: error.localizedDescription)
        }
        else{
            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            self.performSegue(withIdentifier: "goHome", sender: self)
        }
    }

   
        func registerPressed(_ sender: Any) {
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
    

        func LoginTapped(_ sender: UIButton) {
        if let email = emailTextField.text, let pass = passwordTextField.text
        {
            Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
                if user != nil{
                    // user found go home screen
                    self.performSegue(withIdentifier:
                        "goHome", sender: self)
                }
                if let error = error {
                    self.createAlert(title: "Error", message: error.localizedDescription)
                    
                }
            }
        }
        
        }
        


}
}
class homeViewController: UIViewController{
    
}
