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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        var database_ref : DatabaseReference!
        database_ref = Database.database().reference()
        let currentUser = "1001"
        
        database_ref.child(currentUser).observeSingleEvent(of: .value, with: { (snapshot) in
            
            //Snapshot NSDictionary
            let value = snapshot.value as? NSDictionary
            
            //name VALUE
            let nameS = value?["name"] as! String
            
            //lvl VALUE
            let lvlS = value?["xp"] as! Int
            
            //creation VALUE
            let creationS = value?["creation"] as! String
            
            
            self.nameHeaderLabel.text = nameS
            self.levelHeaderlLabel.text = String(lvlS)
            self.memberLabel.text = "Member"
            self.joinedHeaderLabel.text = "Since: " + creationS
            
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
