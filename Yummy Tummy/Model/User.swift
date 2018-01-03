import Foundation

class User{
    let userID:String
    let username:String
    var recipes:[Recipe]
    
    init(userId: String, username: String, recipes: [Recipe]) {
        self.userID = userId
        self.username = username
        self.recipes = recipes
    }
    
    init(userId: String, username: String) {
        self.userID = userId
        self.username = username
        self.recipes = [Recipe]()
    }
}
