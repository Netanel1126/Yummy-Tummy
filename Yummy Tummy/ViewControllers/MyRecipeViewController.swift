import UIKit

class MyRecipeViewController: UIViewController {

    var titelText:String = ""
    var recipeText:String = ""
    @IBOutlet weak var recipeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = titelText
        recipeLabel.text = recipeText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
