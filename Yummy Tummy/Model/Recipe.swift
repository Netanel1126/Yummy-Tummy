import Foundation

class Recipe{
    var recipeText:String
    var autor:String
    var imageUrl:String?
    
    init(recipeText:String,autor:String,imageUrl:String?) {
        self.recipeText = recipeText
        self.autor = autor
        self.imageUrl = imageUrl
    }
    
    init(fromJson:[String:Any]) {
        self.recipeText = fromJson["recipeText"]
        self.autor = fromJson["autor"]
        self.imageUrl = fromJson["imageUrl"]
    }
    
}
