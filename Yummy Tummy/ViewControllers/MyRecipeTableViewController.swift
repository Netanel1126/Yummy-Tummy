//
//  MyRecipeTableViewController.swift
//  Yummy Tummy
//
//  Created by Netanel Yeroshalmi on 28/02/2018.
//  Copyright © 2018 Netanel Yeroshalmi. All rights reserved.
//

import UIKit
class MyRecipeTableViewController: UITableViewController {

    var myRecipes:[Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myRecipes = Model.instance.getAllRecipeFromSQL()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myRecipes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MyRecipeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "my_recipe_cell", for: indexPath) as! MyRecipeTableViewCell
        
        let content = myRecipes[indexPath.row]
        //cell.recipeImge = ToDo
        if content.imageUrl == nil{
            cell.recipeImg.image = UIImage(named: "Logo1")
        }
        cell.recipeTitle.text = content.title
        cell.progress.stopAnimating()
        cell.progress.isHidden = true
        return cell
    }
}
