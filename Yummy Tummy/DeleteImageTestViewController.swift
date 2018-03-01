import UIKit

class DeleteImageTestViewController: UIViewController {

    var recipes:[Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipes = Model.instance.getAllRecipeFromSQL()
        Model.instance.removeRecipeFromDb(recipe: recipes[1])
    }

    @IBAction func deleteYeeZavel(_ sender: Any) {
        print(recipes[1].recpieID)
        Model.instance.removeRecipeFromDb(recipe: recipes[1])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
