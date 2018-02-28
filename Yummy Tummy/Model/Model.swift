import Foundation
import UIKit

class ModelNotificationBase<T>{
    var name:String?
    
    init(name:String){
        self.name = name
    }
    
    func observe(callback:@escaping (T?)->Void)->Any{
        return NotificationCenter.default.addObserver(forName: NSNotification.Name(name!), object: nil, queue: nil) { (data) in
            if let data = data.userInfo?["data"] as? T {
                callback(data)
            }
        }
    }
    
    func post(data:T?){
        NotificationCenter.default.post(name: NSNotification.Name(name!), object: self, userInfo: ["data":data])
    }
}

class ModelNotification{
    static let ConnectedUser = ModelNotificationBase<String>(name: "ConnectedUserNotificatio")
    static let AllRecipes = ModelNotificationBase<[Recipe]>(name: "AllRecipesNotificatio")
    
    static func removeObserver(observer:Any){
        NotificationCenter.default.removeObserver(observer)
    }
}

class Model{
    static let instance = Model()
    let fire = FirebaseModel()
    lazy private var modelSql:SqLiteModel? = SqLiteModel()

    init() {
    }
    
    func getConnectedUser(){
        print("Getting connected User")
        FirebaseModel.getCconnectedUserAndObserve { (userEmail) in
            var user = userEmail
            ModelNotification.ConnectedUser.post(data: user)
        }
    }
    
    func addRecipeToDB(recipe: Recipe){
        recipe.addRecipeToLocalDB(database: self.modelSql?.database)
        FirebaseModel.writRecipeToFB(recipe: recipe)
    }
    
    func getRecipesAndObserve(){
        FirebaseModel.readAllRecipeFromFB { (recipes) in
            ModelNotification.AllRecipes.post(data: recipes!)
        }
    }
    
    func getAllRecipeFromSQL()->[Recipe]{
        return (modelSql?.getAllRecipeFromLocalDB())!
    }
    
    static func saveImageToDatabase(image: UIImage, name: String, callback: @escaping (String?) -> Void) {
        let fileRef = FirebaseModel.storageRef.child(name)
        if let data = UIImageJPEGRepresentation(image, 0.8) {
            fileRef.putData(data, metadata: nil) { metadata, error in
                if error != nil {
                    callback(nil)
                } else {
                    let downloadUrl = metadata!.downloadURL()
                    callback(downloadUrl?.path)
                }
            }
        }
    }
}
