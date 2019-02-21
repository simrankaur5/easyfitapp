
import UIKit
import FirebaseDatabase
import Firebase
import FirebaseUI
import FBSDKLoginKit
import FBSDKCoreKit
class HomeViewController: UIViewController {

    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    
    @IBOutlet weak var lvlLabel: UILabel!
    
    @IBOutlet weak var xpProgressLabel: UILabel!
    
    @IBOutlet weak var calProgressLabel: UILabel!
    
    
    
    @IBOutlet weak var lvlProgress: UIProgressView!
    
    @IBOutlet weak var calProgress: UIProgressView!
    
    
    
    
    
    //@IBOutlet weak var circleView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        

        lvlLabel.font = lvlLabel.font.withSize(40)
        
        lvlProgress.progress = 0
        calProgress.progress = 0
        
        var database_ref : DatabaseReference!
        
        
        database_ref = Database.database().reference()
        
        let currentUser = "1001"
        
//    database_ref.child(currentUser).child("name").observeSingleEvent(of: .value, with: { (snapshot) in
//            // Get user name
//            let value : String = (snapshot.value as? String)!
//            self.welcomeLabel.text = "Welcome " + value
//
//
//
//            // ...
//        }) { (error) in
//            print(error.localizedDescription)
//        }
        
        
        
        database_ref.child(currentUser).observeSingleEvent(of: .value, with: { (snapshot) in
  
            //Snapshot NSDictionary
            let value = snapshot.value as? NSDictionary
            
            //LVL VALUE
            let lvlS = value?["lvl"] as! Int
            
            //XP VALUE
            let xpS = value?["xp"] as! Int
            
            //CALORIES AND CALORIE LIMIT VALUE
            let calorieS = value?["calories"] as! Float
            let calorieLmtS = value?["calorie_limit"] as! Float
            
            //FLOAT VALUE FOR XP AND CALORIE PROGRESS VIEW
            let xpProgress : Float = Float(xpS % 50)*0.02
            let calProgress : Float = Float(calorieS) / Float(calorieLmtS)
            
            
            //DISPLAY LEVEL
            self.lvlLabel.text = String(lvlS)
            
            self.xpProgressLabel.text = String(Int(xpProgress*100)) + "%"
            
            self.calProgressLabel.text = String(Int(calorieS)) + " / " + String(Int(calorieLmtS))
            
            
            //ANIMATE THE PROGRESSVIEW
            UIView.animate(withDuration: 2.5) {
                self.lvlProgress.setProgress(xpProgress, animated: true)
                
                self.calProgress.setProgress(calProgress, animated: true)
            }
            

            
            
            
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
        var welcomeName = ""
        if (Auth.auth().currentUser?.displayName) != nil{
            welcomeName = (Auth.auth().currentUser?.displayName)!
        }
        welcomeLabel.adjustsFontSizeToFitWidth = true
        welcomeLabel.text = "Welcome " + welcomeName
        
        lvlProgress.tintColor = UIColor(red: 0, green: 0.8, blue: 0, alpha: 1.0)
        lvlProgress.trackTintColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        
        //Scaling lvl progress bar
        lvlProgress.transform =  lvlProgress.transform.scaledBy(x: 1,y: 30)
        
        
        
        
        calProgress.tintColor = .yellow
        calProgress.trackTintColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        
        
        //Scaling cal progress bar
        calProgress.transform =  calProgress.transform.scaledBy(x: 1,y: 30)
        
        
        
    }
    
    
}
