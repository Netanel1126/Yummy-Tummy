import Foundation
import UIKit
import Firebase

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
    static let AddRecipe = ModelNotificationBase<Bool>(name: "AddRecipeNotifcation")
    
    static func removeObserver(observer:Any){
        NotificationCenter.default.removeObserver(observer)
    }
}

class Model{ // Model is a Singleton!
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
    
    func addRecipeToDBAndObserve(recipe: Recipe){
        var data = recipe.addRecipeToLocalDB(database: self.modelSql?.database)
        FirebaseModel.writRecipeToFB(recipe: recipe)
        ModelNotification.AddRecipe.post(data: data)
    }
    
    func getRecipesAndObserve(){
        FirebaseModel.readAllRecipeFromFB { (recipes) in
            ModelNotification.AllRecipes.post(data: recipes!)
        }
    }
    
    func getAllRecipeFromSQL()->[Recipe]{
        return (modelSql?.getAllRecipeFromLocalDB())!
    }
    
    func saveImageToDatabase(image: UIImage, name: String, callback: @escaping (String?) -> Void) {
        FirebaseModel.storageRef = Storage.storage().reference(forURL: FirebaseModel.storageRootPath)
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
    
    func getImageFromFirebase(url: String, callback: @escaping (UIImage?) -> Void) {
        FirebaseModel.storageRef = Storage.storage().reference(forURL: url)
        FirebaseModel.storageRef.getData(maxSize: 10000000, completion: { (data, error) in
            if error == nil && data != nil {
                let image = UIImage(data: data!)
                callback(image)
            } else {
                callback(nil)
            }
        })
    }
    
    func saveImageToLocalCache(image: UIImage, name: String) {
        if let data = UIImageJPEGRepresentation(image, 0.8) {
            let fileName = getDocumentDirectory().appendingPathComponent(name)
            try? data.write(to: fileName)
        } else {
            print("Something went wrong with compressing the required image")
        }
    }
    
    func getImageFromLocalCache(name: String) -> UIImage? {
        let fileName = getDocumentDirectory().appendingPathComponent(name)
        return UIImage(contentsOfFile: fileName.path)
    }
    
    private func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        return documentDirectory
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
