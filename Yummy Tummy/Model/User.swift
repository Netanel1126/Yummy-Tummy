import Foundation

class User{
   // let userID:String
    let username:String
    
    init(/*userId: String,
 */username: String, recipes: [Recipe]) {
        //self.userID = userId
        self.username = username
    }
    
    init(/*userId: String,*/ username: String) {
        //self.userID = userId
        self.username = username
    }
    
    init(fromJson: [String:Any]) {
        self.username = fromJson["username"] as! String
    }
    
    func toJson()->[String:Any]{
        var toJson = [String:Any]()
        toJson["username"] = username
        return toJson
    }
}
