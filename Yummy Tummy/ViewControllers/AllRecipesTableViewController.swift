//
//  AllRecipesTableViewController.swift
//  Yummy Tummy
//
//  Created by admin on 01/03/2018.
//  Copyright © 2018 Netanel Yeroshalmi. All rights reserved.
//

import UIKit

class AllRecipesTableViewController: UITableViewController
{
    var recipes: [Recipe] = []
    var precedCellIndex = 0
    var precedCellImg:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ModelNotification.AllRecipes.observe { (fb_recipes) in
            self.recipes = fb_recipes!
            self.tableView.reloadData()
        }
        
        Model.instance.getRecipesAndObserve()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(recipes.count)
        return recipes.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSelectedRecipe" {
            let recipe = recipes[precedCellIndex]
            let destVewController = segue.destination as! AllRecipesViewController
            
            destVewController.titleText = recipe.title
            destVewController.recipeText = recipe.recipeText
            if recipe.imageUrl == nil{
                destVewController.image = UIImage(named: "Logo1")!
            } else {
                destVewController.image = precedCellImg!
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! AllRecipesTableViewCell
        
        let content = recipes[indexPath.row]
        if content.imageUrl == nil {
            cell.recipeImage.image = UIImage(named: "Logo1")
        } else {
            Model.instance.getImageFromFirebase(url: content.imageUrl!, callback: { image in
                cell.recipeImage.image = image!
            })
        }
        cell.recipeTitle.text = content.title
        cell.spiner.stopAnimating()
        cell.spiner.isHidden = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        precedCellIndex = (tableView.indexPathForSelectedRow?.row)!
        let cell = tableView.cellForRow(at: tableView.indexPathForSelectedRow!) as! AllRecipesTableViewCell
        precedCellImg = cell.recipeImage.image
        self.performSegue(withIdentifier: "toSelectedRecipe", sender: nil)
    }
}
