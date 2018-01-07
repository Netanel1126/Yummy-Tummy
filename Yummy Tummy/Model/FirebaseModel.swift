import Foundation
import Firebase
import FirebaseDatabase

class FirebaseModel{
    let ref:DatabaseReference?
    
    init(){
        FirebaseApp.configure()
        ref = Database.database().reference()
    }
    
    func writeUserToFirebase(newUser:User) -> Bool{
        var myRef = ref?.child("Users")
        var validateUsername:Bool;
        readUserFromFirebase(byId: newUser.username) {(user) in
            if user != nil{
                myRef.setValue(newUser.toJson())
                validateUsername = true
            }
            else{
                validateUsername = false
                }
        }
        return true
    }
    
    func readUserFromFirebase(byId:String, callback: @escaping (User?) -> Void){
        let myRef = ref?.child("Users").child(byId)
        
        myRef?.observeSingleEvent(of: .value, with: { (snapshot) in
            if let val = snapshot.value as? [String:Any]{
                let user = User(fromJson: val)
                callback(user)
            }else{
                callback(nil)
            }
        })
    }
}
