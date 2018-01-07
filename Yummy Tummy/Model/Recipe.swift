import Foundation

class Recipe{
    var recpieID:String
    var recipeText:String
    var title:String
    var autor:String
    var imageUrl:String?
    
    init(recpieID:String,recipeText:String,autor:String,imageUrl:String?,title:String) {
        self.recpieID = recpieID
        self.title = title
        self.recipeText = recipeText
        self.autor = autor
        self.imageUrl = imageUrl
    }
    
    init(fromJson:[String:Any]) {
        self.recpieID = fromJson["recipeID"] as! String
        self.recipeText = fromJson["recipeText"] as! String
        self.title = fromJson["title"] as! String
        self.autor = fromJson["autor"] as! String
        self.imageUrl = fromJson["imageUrl"] as! String?
    }
    
    func toJson()->[String:Any]{
        var toJson = [String:Any]()
        toJson["autor"] = autor
        toJson["recpieID"] = recpieID
        toJson["title"] = title
        toJson["recipeText"] = recipeText
        toJson["imageUrl"] = imageUrl!
        return toJson
    }
    
}
