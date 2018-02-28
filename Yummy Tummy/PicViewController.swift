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
    
    @IBAction func postImageToFirebase(_ sender: Any) {
        Model.saveImageToDatabase(image: selectedImage!, name: titleText.text! + ".png") { name in print(name) }
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
