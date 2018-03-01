//
//  PicViewController.swift
//  Yummy Tummy
//
//  Created by Ben Ohayon on 28/02/2018.
//  Copyright © 2018 Netanel Yeroshalmi. All rights reserved.
//

import UIKit
import Firebase

class PicViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var progressSpinner: UIActivityIndicatorView!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var stImage: UIImageView!
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        selectedImage = info["UIImagePickerControllerOriginalImage"] as? UIImage
        self.stImage.image = selectedImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func getPictureFromGallery(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.allowsEditing = true
            present(controller, animated: true, completion: nil)
        }
    }
    
    @IBAction func postImage(_ sender: Any) {
        self.progressSpinner.startAnimating()
        Model.instance.saveImageToDatabase(image: selectedImage!, name: titleText.text! + ".jpg") { imageFirebasePath in
            if imageFirebasePath != nil {
                // After saving the recipe image in Firebase Storage, save its url in the Firebase Database and add the recipe to local cache
                // as a file and as an entry in SQLite local database.
                Model.instance.saveImageToLocalCache(image: self.selectedImage!, name: self.titleText.text!)
                Model.instance.addRecipeToDBAndObserve(recipe: Recipe(recipeText: "", autor: "", imageUrl: imageFirebasePath, title: self.titleText.text!))
                self.progressSpinner.stopAnimating()
            }
        }
    }
    
    // Testing
    @IBAction func getPictureFromStorage(_ sender: Any) {
        self.progressSpinner.startAnimating()
        Model.instance.getImageFromFirebase(url: FirebaseModel.storageRootPath + "/myPic.jpg") { (image) in
            if image != nil {
                self.selectedImage = image!
                self.stImage.image = self.selectedImage
            } else {
                print("nil was returned from Firebase")
            }
            self.progressSpinner.stopAnimating()
        }
    }
    
    
    
    
    
    
    
    
    
    
}
