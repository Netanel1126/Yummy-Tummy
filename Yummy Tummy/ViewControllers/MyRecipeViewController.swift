import UIKit

class MyRecipeViewController: UIViewController {

    var titelText:String = ""
    var recipeText:String = ""
    var image:UIImage = UIImage(named: "Logo1")!
    var myRecipe:Recipe?
    @IBOutlet weak var recipeImg: UIImageView!
    @IBOutlet weak var recipeTextView: UITextView!
    @IBOutlet weak var spiner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = titelText
        recipeTextView.text = recipeText
        recipeImg.image = image
    }

    override func viewDidAppear(_ animated: Bool) {
        spiner.stopAnimating()
        spiner.isHidden = true
    }
    @IBAction func deleteBtn(_ sender: Any) {
        Model.instance.removeRecipeFromDb(recipe: myRecipe!)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
