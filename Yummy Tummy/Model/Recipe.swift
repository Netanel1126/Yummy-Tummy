import Foundation

extension String {
    public init?(validatingUTF8 cString: UnsafePointer<UInt8>) {
        if let (result, _) = String.decodeCString(cString, as: UTF8.self,
                                                  repairingInvalidCodeUnits: false) {
            self = result
        }
        else {
            return nil
        }
    }
}

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
        if imageUrl != nil{
            toJson["imageUrl"] = imageUrl!
        }else{imageUrl = ""}
        return toJson
    }
    
}
