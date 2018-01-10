import Foundation
import Firebase
import FirebaseDatabase

class FirebaseModel{
    let ref:DatabaseReference?
    var validateUsername:Bool;

    init(){
        FirebaseApp.configure()
        ref = Database.database().reference()
        
        validateUsername = false
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
