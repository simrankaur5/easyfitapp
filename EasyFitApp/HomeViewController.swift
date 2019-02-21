
import UIKit
import FirebaseDatabase
import Firebase
import FirebaseUI
class HomeViewController: UIViewController {

    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    
    
    
    @IBOutlet weak var lvlProgress: UIProgressView!
    
    @IBOutlet weak var calProgress: UIProgressView!
    
    //@IBOutlet weak var circleView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        var welcomeName:String = ""
        
        let database_ref = Database.database().reference()

        database_ref.child("1001/name").setValue("TEST")
        //        database_ref.child("100001/Name").observeSingleEvent(of: .value, with: { (snapshot) in
//            // Get welcome name
//            let wName = snapshot.value as! String
//
//            welcomeName = wName
//
//
//        })
   
//        welcomeLabel.text = w_Name
//        FirebaseUser; user = FirebaseAuth.getInstance().getCurrentUser();
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
