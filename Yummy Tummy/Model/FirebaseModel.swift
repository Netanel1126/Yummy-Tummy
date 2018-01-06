import Foundation
import Firebase
import FirebaseDatabase

class FirebaseModel{
    let ref:DatabaseReference?
    
    init(){
        FirebaseApp.configure()
        ref = Database.database().reference()
    }
}
