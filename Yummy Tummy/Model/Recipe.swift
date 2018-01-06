import Foundation

class Recipe{
    var recipeText:String
    var autor:String
    var imageUrl:String?
    
    init(recipeText:String,autor:String) {
        self.recipeText = recipeText
        self.autor = autor
    }
    
}
