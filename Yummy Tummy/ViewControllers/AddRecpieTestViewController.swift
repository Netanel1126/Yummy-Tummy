import UIKit

class AddRecpieTestViewController: UIViewController,UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var recipeText: UITextView!
    @IBOutlet weak var title1: UITextField!
    @IBOutlet weak var recipeImage: UIImageView!
    var selectedImage: UIImage?
    
    var PLACEHOLDER_TEXT:String = "(Example Recipe)\n"
        + "Ingredients\n1 cup Nutella\n1 egg\n1 cup flour\nDirections\n1. Pre-heat oven to 350 degrees\n" +
    "2. Mix all ingredients together\n3. Bake for 6-8 minutes\n4. Push down with  a fork while they are still warm"
    
    var autor:String = ""
    var firstTime = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ModelNotification.ConnectedUser.observe { (user) in
            self.autor = user!
        }
        
        ModelNotification.AddRecipe.observe { (saved) in
            if(saved)!{
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        recipeText?.delegate = self
        applyPlaceholderStyle(aTextview: recipeText, placeholderText: PLACEHOLDER_TEXT)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        selectedImage = info["UIImagePickerControllerOriginalImage"] as? UIImage
        self.recipeImage.image = selectedImage
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func getImageFromGallery(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.allowsEditing = true
            present(controller, animated: true, completion: nil)
        }
    }
    
    @IBAction func add(_ sender: UIButton) {
        //Model.instance.getConnectedUser()
        Model.instance.saveImageToDatabase(image: selectedImage!, name: title1.text!, callback: { imageFirebasePath in
            Model.instance.saveImageToLocalCache(image: selectedImage!, name: imageFirebasePath)
            Model.instance.addRecipeToDBAndObserve(recipe: Recipe(recipeText: self.recipeText.text!, autor: self.autor, imageUrl: imageFirebasePath, title: self.title1.text!))
        })
    }
    
    func applyPlaceholderStyle(aTextview: UITextView, placeholderText: String)
    {
        aTextview.textColor = UIColor.lightGray
        aTextview.text = placeholderText
    }
    
    func applyNonPlaceholderStyle(aTextview: UITextView)
    {
        aTextview.textColor = UIColor.darkText
        aTextview.alpha = 1.0
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if(firstTime){
            recipeText.text = ""
            applyNonPlaceholderStyle(aTextview: recipeText)
            firstTime = false
        }
    }
}
