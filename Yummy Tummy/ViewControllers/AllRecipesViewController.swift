//
//  AllRecipesViewController.swift
//  Yummy Tummy
//
//  Created by admin on 01/03/2018.
//  Copyright © 2018 Netanel Yeroshalmi. All rights reserved.
//

import UIKit

class AllRecipesViewController: UIViewController {
    
    @IBOutlet weak var loadingImage: UIActivityIndicatorView!
    @IBOutlet weak var presentedImage: UIImageView!
    @IBOutlet weak var recipeDesc: UITextView!
    var image: UIImage?
    var titleText: String?
    var recipeText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentedImage.image = image
        self.title = titleText
        recipeDesc.text = recipeText!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadingImage.stopAnimating()
    }

}
