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
class ViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var registerEmailTextField: UITextField!
    
    @IBOutlet weak var registerPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerConfirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func registerPressed(_ sender: Any) {
//        if let registerEmail = registerEmailTextField.text , let registerPass = passwordTextField.text{
      if  let email = registerEmailTextField.text, let pass = registerPasswordTextField.text
      {
                Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
                    
                    if user != nil{
                        self.performSegue(withIdentifier: "goHome", sender: self)
                        
                    }
                }
            
        }
           
        
    }
    
   
    
    @IBAction func LoginTapped(_ sender: UIButton) {
        if let email = emailTextField.text, let pass = passwordTextField.text
        {
            Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
                if user != nil{
                    // user found go home screen
                    self.performSegue(withIdentifier:
                        "goHome", sender: self)
                }
                else {
                    //error check error and show message
                }
            }
        }
        
        }
        //Get the default auth ui obj
//        let authUI = FUIAuth.defaultAuthUI()
//        guard authUI != nil else{
//            return
//        }
        
        //Set ourselves as delegate
//        authUI?.delegate = self
//        //Get a refference  to the auth ui view controller
//        let authViewController = authUI!.authViewController()
//        //show
//        present(authViewController, animated: true, completion: nil)
//    }
}
//override func touchesBegan(_ touches: Set<UITouch>, with event:UIEvent?){
//    //Dismiss keyboard when view is tapped
//    emailTextField.resignFirstResponder()
//    passwordTextField.resignFirstResponder()
//
//}


//extension ViewController: FUIAuthDelegate{
//    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
//        //Check for error
//        guard error == nil else{
//            //log error
//            return
//        }
//        //authDataResult?.user.uid
//        performSegue(withIdentifier: "goHome", sender: self)
//    }
//
//}

