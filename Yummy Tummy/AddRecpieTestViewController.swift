import UIKit

class AddRecpieTestViewController: UIViewController {
    
    @IBOutlet weak var Text: UITextField!
    @IBOutlet weak var title1: UITextField!
    var autor:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ModelNotification.ConnectedUser.observe { (user) in
            self.autor = user!
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func add(_ sender: UIButton) {
        Model.instance.getConnectedUser()
        Model.instance.addRecipeToDB(recipe: Recipe(recipeText: Text.text!, autor: autor, imageUrl: nil, title: title1.text!))
        
        Model.instance.getAllRecipeFromSQL()
    }
    
}
