import UIKit
class MyRecipeTableViewController: UITableViewController {

    var myRecipes:[Recipe] = []
    var precedCellIndex = 0
    
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMyRecipe" {
            let recipe = myRecipes[precedCellIndex]
            let destVewController = segue.destination as! MyRecipeViewController
            
            destVewController.titelText = recipe.title
            destVewController.recipeText = recipe.recipeText
            if recipe.imageUrl == nil{
                destVewController.image = UIImage(named: "Logo1")!
            }
            //destVewController.recipeImg.image = /ToDo/
        }
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        precedCellIndex = (tableView.indexPathForSelectedRow?.row)!
        self.performSegue(withIdentifier: "toMyRecipe", sender: nil)
    }
}
