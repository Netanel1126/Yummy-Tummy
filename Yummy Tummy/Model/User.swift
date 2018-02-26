import Foundation

class User{
    let username:String
    
    init(userId: String,
   username: String, recipes: [Recipe]) {
        self.username = username
    }
    
    init(username: String) {
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
