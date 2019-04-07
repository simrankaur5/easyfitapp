//
//  ProfileViewController.swift
//  EasyFitApp
//
//  Created by user149446 on 2/22/19.
//  Copyright © 2019 Michal Nowak. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseUI
import FBSDKLoginKit
import FBSDKCoreKit

class ProfileViewController: UIViewController {

    
    
    @IBOutlet weak var nameHeaderLabel: UILabel!
    
    
    @IBOutlet weak var levelHeaderlLabel: UILabel!
    
    
    @IBOutlet weak var memberLabel: UILabel!
    
    @IBOutlet weak var joinedHeaderLabel: UILabel!
    
    
    @IBOutlet weak var profileImg: UIImageView!
    
    
    
    //CURRENT PROGRESS LABELS
    @IBOutlet weak var detailsMainL: UILabel!
    
    @IBOutlet weak var detailsL1: UILabel!
    @IBOutlet weak var detailsL2: UILabel!
    @IBOutlet weak var detailsL3: UILabel!
    
            //HEADER LABELS
    @IBOutlet weak var detailsHL1: UILabel!
    @IBOutlet weak var detailsHL2: UILabel!
    @IBOutlet weak var detailsHL3: UILabel!
    
    //GOALS LABELS
    
    @IBOutlet weak var goalsMainL: UILabel!
    
    
    @IBOutlet weak var goalsL1: UILabel!
    @IBOutlet weak var goalsL2: UILabel!
    @IBOutlet weak var goalsL3: UILabel!
    
    @IBOutlet weak var goalsHL1: UILabel!
    @IBOutlet weak var goalsHL2: UILabel!
    @IBOutlet weak var goalsHL3: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //CURRENT PROGRESS INIT
        
        detailsL1.layer.borderColor = UIColor.black.cgColor
        detailsL1.layer.borderWidth = 4.0
        detailsL1.layer.cornerRadius = 8

        detailsL2.layer.borderColor = UIColor.black.cgColor
        detailsL2.layer.borderWidth = 4.0
        detailsL2.layer.cornerRadius = 8
        
        detailsL3.layer.borderColor = UIColor.black.cgColor
        detailsL3.layer.borderWidth = 4.0
        detailsL3.layer.cornerRadius = 8
        
        detailsMainL.text = "DETAILS"
        
        
        
        
        detailsHL1.text = "Weight"
        detailsHL2.text = "Height"
        detailsHL3.text = "Age"
        
        //GOALS INIT
        
        goalsL1.layer.borderColor = UIColor.black.cgColor
        goalsL1.layer.borderWidth = 4.0
        goalsL1.layer.cornerRadius = 8
        
        goalsL2.layer.borderColor = UIColor.black.cgColor
        goalsL2.layer.borderWidth = 4.0
        goalsL2.layer.cornerRadius = 8
        
        goalsL3.layer.borderColor = UIColor.black.cgColor
        goalsL3.layer.borderWidth = 4.0
        goalsL3.layer.cornerRadius = 8
        
        goalsMainL.text = "MY GOALS"
        
        
        var goalsHArray = ["Distance", "Pace"]
        var goalsVArray = ["Run 500km", "Average 300m/min"]
    
        for i in 0...2 {
            if goalsVArray.indices.contains(i)
            {

                if i == 0
                {
                    goalsL1.isHidden = false
                    goalsHL1.isHidden = false
                    goalsL1.text = goalsVArray[i]
                    goalsHL1.text = goalsHArray[i]
                }
                else if i == 1
                {
                    goalsL2.isHidden = false
                    goalsHL2.isHidden = false
                    goalsL2.text = goalsVArray[i]
                    goalsHL2.text = goalsHArray[i]
                }
                else if i == 2
                {
                    goalsL3.isHidden = false
                    goalsHL3.isHidden = false
                    goalsL3.text = goalsVArray[i]
                    goalsHL3.text = goalsHArray[i]
                }
                
            }
            else
            {
                if i == 0
                {
                    goalsL1.isHidden = true
                    goalsHL1.isHidden = true
                }
                else if i == 1
                {
                    goalsL2.isHidden = true
                    goalsHL3.isHidden = true
                }
                else if i == 2
                {
                    goalsL3.isHidden = true
                    goalsHL3.isHidden = true
                }
            }
        }
        
        
        
        
        
        //DATABASE REFERENCE
        var database_ref : DatabaseReference!
        database_ref = Database.database().reference()
        let currentUser = Auth.auth().currentUser
        let currentUserID:String = currentUser!.uid
        
        database_ref.child("users/" + currentUserID + "/personal").observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            //Snapshot NSDictionary
            let value = snapshot.value as? NSDictionary
            
            //name VALUE
            let nameS = value?["name"] as! String
            
        
            let currentWeightS = value?["weight"] as! String
            let currentHeightS = value?["height"] as! String
            let currentAgeS = value?["age"] as! String
            
            self.nameHeaderLabel.text = nameS
       
            self.memberLabel.text = "Member"

            
            self.detailsL1.text = String(currentWeightS) + "kg"
            self.detailsL2.text = String(currentHeightS) + "cm"
            self.detailsL3.text = String(currentAgeS) + "y"
            
            
            })
        
        database_ref.child("users/" + currentUserID + "/stats").observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            //Snapshot NSDictionary
            let value = snapshot.value as? NSDictionary
            
            //lvl VALUE
            let lvlS = value?["lvl"] as! Int
            
            //creation VALUE
            let creationS = value?["creationDate"] as! String
            
            self.levelHeaderlLabel.text = "Level : " + String(lvlS)
            self.joinedHeaderLabel.text = creationS
            
            
        })
        
        
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
