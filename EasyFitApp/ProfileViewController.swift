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
    
    
    
    @IBOutlet weak var currentProgressMainL: UILabel!
    
    
    @IBOutlet weak var currentProgressL1: UILabel!
    
    @IBOutlet weak var currentProgressL2: UILabel!
    
    @IBOutlet weak var currentProgressL3: UILabel!
    
    
    @IBOutlet weak var currentProgressHL1: UILabel!
    
    @IBOutlet weak var currentProgressHL2: UILabel!
    
    @IBOutlet weak var currentProgressHL3: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
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
            let currentPaceS = value?["current_pace"] as! Float
            
            self.nameHeaderLabel.text = nameS
            self.levelHeaderlLabel.text = "Level : " + String(lvlS)
            self.memberLabel.text = "Member"
            self.joinedHeaderLabel.text = creationS
            
            self.currentProgressL1.text = String(currentWeightS)
            self.currentProgressL2.text = String(currentPaceS)
            self.currentProgressL3.text = String(currentDistanceS)
            
            
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
