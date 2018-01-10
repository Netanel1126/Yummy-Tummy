import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    let fireModel = FirebaseModel()
    
    @IBOutlet weak var errorLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addUser(_ sender: Any) {
        var newUser = User(username: textField.text!)
        
        fireModel.readUserFromFirebase(byId: newUser.username, callback: {(user) in
            if(user == nil){
                self.fireModel.writeUserToFirebase(newUser: newUser)
            }else{
                self.errorLable.text = "Username Exsits Please Try Again"
            }
        })
    
    }
    
}

