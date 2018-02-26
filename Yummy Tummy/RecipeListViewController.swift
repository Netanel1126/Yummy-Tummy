//
//  RecipeListViewController.swift
//  Yummy Tummy
//
//  Created by admin on 26/02/2018.
//  Copyright © 2018 Netanel Yeroshalmi. All rights reserved.
//

import UIKit

class RecipeListViewController: UITableViewController {
    
    let firebase = FirebaseModel()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firebase.getNumberOfImages()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)

        recipeImage.image = firebase.image

        return cell
    }
}
