import Foundation
import Firebase
import FirebaseDatabase
import GoogleSignIn
import FBSDKCoreKit

class FirebaseModel: NSObject, GIDSignInDelegate {
    static var ref:DatabaseReference?
    //var image: UIImage
    
    override init(){
        
        FirebaseModel.ref = Database.database().reference()
        super.init()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
    }
    
    func getNumberOfImages() -> Int {
        return Storage.storage().reference().root().accessibilityElementCount()
    }
    
    /*func getImage(fromURI: String) -> UIImage {
        let storageRef = Storage.storage().reference(forURL: fromURI)
        storageRef.getData(maxSize: 650 * 1024) { data, error in
            if error != nil {
            print(error)
            return
            }
            
            image = UIImage(data: data!)
        }
    }*/
    
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
    
   static func getCconnectedUserAndObserve(callback: @escaping (String?)-> Void){
    let userEmail = Auth.auth().currentUser?.email;
    var test = Auth.auth().currentUser;
    if userEmail != nil {
        print ("E: ", test?.email,"U: " , test?.uid ,"P: " , test?.photoURL)
        callback(userEmail)
    }
    else{
        callback(nil)
    }
    }
    
   static func writRecipeToFB(recipe:Recipe){
        var myRef = ref?.child("Recipe").child(recipe.recpieID)
        myRef?.setValue(recipe.toJson())
    }
    
    static func readAllRecipeFromFB(callback: @escaping ([Recipe]?) -> Void){
        var myRef = ref?.child("Recipe")
        var myRecipes = [Recipe]()
        
        let handler = {(snapshot:DataSnapshot) in
            for child in snapshot.children.allObjects{
                if let childData = child as? DataSnapshot{
                    if let json = childData.value as? Dictionary<String,Any>{
                        let rec = Recipe(fromJson: json)
                        myRecipes.append(rec)
                    }
                }
            }
            callback(myRecipes)
        }
        
        myRef?.observe(DataEventType.value, with: handler)
    }
    
    static func readRecipe(byId: String, callback: @escaping (Recipe?) -> Void){
        var myRef = ref?.child("Recipe").child(byId)
        
        myRef?.observeSingleEvent(of: .value, with: { (snapshot) in
            if let val = snapshot.value as? [String:Any]{
                let recipe = Recipe(fromJson: val)
                callback(recipe)
            }else{
                callback(nil)
            }
        })
    }
    
    func writeUserToFirebase(newUser:User){
        var myRef = FirebaseModel.ref?.child("Users").child(newUser.username)
        myRef?.setValue(newUser.toJson())
    }
    
    func readUserFromFirebase(byId:String, callback: @escaping (User?) -> Void){
        let myRef = FirebaseModel.ref?.child("Users").child(byId)
        
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
