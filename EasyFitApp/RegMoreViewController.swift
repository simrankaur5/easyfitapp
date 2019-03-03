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

class RegMoreViewController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource {

    let genderArray = ["Male","Female"]

    @IBOutlet weak var genderTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        createGenderPickerView()
        createToolBar(textfield: genderTextField)

    }
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var CalorieTextField: UITextField!
    
    @IBOutlet weak var heightTextField: UITextField!
    
    @IBOutlet weak var weightTextField: UITextField!
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func createGenderPickerView(){
        let genderPicker = UIPickerView()
        genderPicker.delegate = self
        genderTextField.text = genderArray[0]
        genderTextField.inputView = genderPicker
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return genderArray.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTextField.text = genderArray[row]

    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderArray[row]
    }


    func  createToolBar(textfield: UITextField) {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain ,target: self, action: #selector(ViewController.dismissKeyboard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textfield.inputAccessoryView = toolBar
    }

    @IBAction func registerPressed(_ sender: Any) {
        
        if let height = heightTextField.text, let gender = genderTextField.text, let weight = weightTextField.text , let name = nameTextField.text , let calorie = Int(CalorieTextField.text!) {
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            let result = formatter.string(from: date)
                    if let user = Auth.auth().currentUser {
                        

                        if FBSDKAccessToken.current() != nil {
                            database_ref.child("users/\(user.uid)/stats/lvl").setValue(0)
                            database_ref.child("users/\(user.uid)/stats/xp").setValue(0)
                            database_ref.child("users/\(user.uid)/stats/calorie_limit").setValue(calorie)
                            database_ref.child("users/\(user.uid)/stats/calories").setValue(0)
                            database_ref.child("users/\(user.uid)/stats/creationDate").setValue(result)
                            database_ref.child("users/\(user.uid)/personal/weight").setValue(weight)
                            database_ref.child("users/\(user.uid)/personal/height").setValue(height)
                            database_ref.child("users/\(user.uid)/personal/gender").setValue(gender)
                            nameTextField.text = user.displayName
                            database_ref.child("users/\(user.uid)/personal/name").setValue(user.displayName)
                            self.performSegue(withIdentifier: "regMoreToHome", sender: self)
                        }
                        else {
                            database_ref.child("users/\(user.uid)/stats/lvl").setValue(0)
                            database_ref.child("users/\(user.uid)/stats/xp").setValue(0)
                            database_ref.child("users/\(user.uid)/stats/calorie_limit").setValue(calorie)
                            database_ref.child("users/\(user.uid)/stats/calories").setValue(0)
                            database_ref.child("users/\(user.uid)/stats/creationDate").setValue(result)
                            database_ref.child("users/\(user.uid)/personal/weight").setValue(weight)
                            database_ref.child("users/\(user.uid)/personal/height").setValue(height)
                            database_ref.child("users/\(user.uid)/personal/gender").setValue(gender)
                            database_ref.child("users/\(user.uid)/personal/name").setValue(name)
                            self.performSegue(withIdentifier: "regMoreToHome", sender: self)
                        }
        
                    }
            
                }
                else{
                    ViewController().createAlert(title: "error",message: "Please fill in all the fields")
                            }
    }
    //    @IBAction func registerPressed(_ sender: Any) {
//        if let height = heightTextField.text, let gender = Gender, let weight = weightTextField.text , let name = nameTextField.text {
//            if let user = Auth.auth().currentUser {
//                if FBSDKAccessToken.current() != nil {
//                    database_ref.child("users/\(user.uid)/stats/lvl").setValue(0)
//                    database_ref.child("users/\(user.uid)/stats/xp").setValue(0)
//                    database_ref.child("users/\(user.uid)/stats/calorie_limit").setValue(2000)
//                    database_ref.child("users/\(user.uid)/stats/calories").setValue(0)
//                    database_ref.child("users/\(user.uid)/personal/weight").setValue(weight)
//                    database_ref.child("users/\(user.uid)/personal/height").setValue(height)
//                    database_ref.child("users/\(user.uid)/personal/gender").setValue(gender)
//                    database_ref.child("users/\(user.uid)/personal/name").setValue(user.displayName)
//                }
//                else {
//                    database_ref.child("users/\(user.uid)/stats/lvl").setValue(0)
//                    database_ref.child("users/\(user.uid)/stats/xp").setValue(0)
//                    database_ref.child("users/\(user.uid)/stats/calorie_limit").setValue(2000)
//                    database_ref.child("users/\(user.uid)/stats/calories").setValue(0)
//                    database_ref.child("users/\(user.uid)/personal/weight").setValue(weight)
//                    database_ref.child("users/\(user.uid)/personal/height").setValue(height)
//                    database_ref.child("users/\(user.uid)/personal/gender").setValue(gender)
//                }
//
//            }
//            self.performSegue(withIdentifier: "regMoreToLogin", sender: self)
//        }
//        else{
//            ViewController().createAlert(title: "error",message: "Please fill in all the fields")
//                    }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


