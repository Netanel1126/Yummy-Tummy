import UIKit

class AddRecpieTestViewController: UIViewController {
    
    @IBOutlet weak var Text: UITextField!
    @IBOutlet weak var title1: UITextField!
    @IBOutlet weak var autor: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func add(_ sender: UIButton) {
        Model.instance.addRecipeToDB(recipe: Recipe(recpieID: "Test" , recipeText: Text.text!, autor: autor.text!, imageUrl: nil, title: title1.text!))
        
        Model.instance.getAllRecipeFromSQL()
    }
    
}
