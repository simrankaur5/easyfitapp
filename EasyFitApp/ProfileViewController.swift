//
//  ProfileViewController.swift
//  EasyFitApp
//
//  Created by user149446 on 2/22/19.
//  Copyright © 2019 Michal Nowak. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class ProfileViewController: UIViewController {

    
    
    @IBOutlet weak var nameHeaderLabel: UILabel!
    
    
    @IBOutlet weak var levelHeaderlLabel: UILabel!
    
    
    @IBOutlet weak var memberLabel: UILabel!
    
    @IBOutlet weak var joinedHeaderLabel: UILabel!
    
    
    @IBOutlet weak var profileImg: UIImageView!
    
    
    
    //CURRENT PROGRESS LABELS
    @IBOutlet weak var currentProgressMainL: UILabel!
    
    @IBOutlet weak var currentProgressL1: UILabel!
    @IBOutlet weak var currentProgressL2: UILabel!
    @IBOutlet weak var currentProgressL3: UILabel!
    
            //HEADER LABELS
    @IBOutlet weak var currentProgressHL1: UILabel!
    @IBOutlet weak var currentProgressHL2: UILabel!
    @IBOutlet weak var currentProgressHL3: UILabel!
    
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
        
        currentProgressL1.layer.borderColor = UIColor.black.cgColor
        currentProgressL1.layer.borderWidth = 4.0
        currentProgressL1.layer.cornerRadius = 8

        currentProgressL2.layer.borderColor = UIColor.black.cgColor
        currentProgressL2.layer.borderWidth = 4.0
        currentProgressL2.layer.cornerRadius = 8
        
        currentProgressL3.layer.borderColor = UIColor.black.cgColor
        currentProgressL3.layer.borderWidth = 4.0
        currentProgressL3.layer.cornerRadius = 8
        
        currentProgressMainL.text = "CURRENT PROGRESS"
        
        
        
        
        currentProgressHL1.text = "Weight"
        currentProgressHL2.text = "Pace"
        currentProgressHL3.text = "Distance"
        
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
        
        
        var goalsHArray = ["Distance", "Testing"]
        var goalsVArray = ["Distance", "Testing"]
    
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
        let currentUser = "1001"
        
        database_ref.child(currentUser).observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            //Snapshot NSDictionary
            let value = snapshot.value as? NSDictionary
            
            //name VALUE
            let nameS = value?["name"] as! String
            
            //lvl VALUE
            let lvlS = value?["lvl"] as! Int
            
            //creation VALUE
            let creationS = value?["creation"] as! String
            
            let currentWeightS = value?["current_weight"] as! Int
            let currentDistanceS = value?["current_distance"] as! Int
            let currentPaceS = value?["current_pace"] as! Double
            
            self.nameHeaderLabel.text = nameS
            self.levelHeaderlLabel.text = "Level : " + String(lvlS)
            self.memberLabel.text = "Member"
            self.joinedHeaderLabel.text = creationS
            
            self.currentProgressL1.text = String(currentWeightS) + "kg"
            self.currentProgressL2.text = String(currentPaceS) + "m/s"
            self.currentProgressL3.text = String(currentDistanceS) + "km"
            
            
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
