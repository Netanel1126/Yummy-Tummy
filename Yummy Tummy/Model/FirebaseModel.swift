import Foundation
import Firebase
import FirebaseDatabase
import GoogleSignIn
import FBSDKCoreKit

class FirebaseModel: NSObject, GIDSignInDelegate {
    static let storageRootPath = "gs://yummy-tummy-5bdc2.appspot.com"
    static var storageRef = Storage.storage().reference(forURL: storageRootPath)
    static var databaseRef:DatabaseReference? = Database.database().reference()
    var image: UIImage!
    
    override init(){
        super.init()
        FirebaseModel.databaseRef = Database.database().reference()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
    }
    
    func getNumberOfImages() -> Int {
        return Storage.storage().reference().root().accessibilityElementCount()
    }
    
    // Consider to remove (?)
    func getImage(fromURI: String) {
        let storageRef = Storage.storage().reference(forURL: fromURI)
        storageRef.getData(maxSize: 650 * 1024) { data, error in
            if error != nil {
                print(error!)
                return
            }
            
            self.image = UIImage(data: data!)
        }
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
    
   static func getCconnectedUserAndObserve(callback: @escaping (String?)-> Void){
        let userEmail = Auth.auth().currentUser?.email;
        let test = Auth.auth().currentUser;
        if userEmail != nil {
            print("E: ", test?.email,"U: " , test?.uid ,"P: " , test?.photoURL)
            callback(userEmail)
        }
        else{
            callback(nil)
        }
    }
    
   static func writRecipeToFB(recipe:Recipe){
        let myRef = databaseRef?.child("Recipe").child(recipe.recpieID)
        myRef?.setValue(recipe.toJson())
    }
    
    static func readAllRecipeFromFB(callback: @escaping ([Recipe]?) -> Void){
        let myRef = databaseRef?.child("Recipe")
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
        let myRef = databaseRef?.child("Recipe").child(byId)
        
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
        let myRef = FirebaseModel.databaseRef?.child("Users").child(newUser.username)
        myRef?.setValue(newUser.toJson())
    }
    
    func readUserFromFirebase(byId:String, callback: @escaping (User?) -> Void){
        let myRef = FirebaseModel.databaseRef?.child("Users").child(byId)
        
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
