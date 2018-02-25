import Foundation
import Firebase
import FirebaseDatabase
import GoogleSignIn
import FBSDKCoreKit

class FirebaseModel: NSObject, GIDSignInDelegate {
    let ref:DatabaseReference?
    //var validateUsername:Bool;
    
    override init(){
        
        FirebaseApp.configure()
        ref = Database.database().reference()
        super.init()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
      //  validateUsername = false
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let err = error {
            print("ERROR - Failed to log into Google: ",err)
            return
        }
        print("Successfully logged into google", user)
        guard let idToken = user.authentication.idToken else {return}
        guard let accessToken = user.authentication.accessToken else {return}
        
        let credentials = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        Auth.auth().signIn(with: credentials) { (user, error) in
            if let err = error {
                print("ERROR - Failed to create a Firebase User With Google account ",err)
            }
            
            print(user," Logged In")
        }
    }
    
    
    func writeUserToFirebase(newUser:User){
        var myRef = ref?.child("Users").child(newUser.username)
        myRef?.setValue(newUser.toJson())
    }
    
    func readUserFromFirebase(byId:String, callback: @escaping (User?) -> Void){
        let myRef = ref?.child("Users").child(byId)
        
        myRef?.observeSingleEvent(of: .value, with: { (snapshot) in
            if let val = snapshot.value as? [String:Any]{
                let user = User(fromJson: val)
                callback(user)
            }else{
                print("User is nil")
                callback(nil)
            }
        })
    }
}
