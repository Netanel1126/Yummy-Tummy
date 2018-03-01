import UIKit
import Firebase

class RecipeListViewController: UITableViewController {
    
    let firebase = FirebaseModel()
    
    override func viewDidLoad() {
        FirebaseApp.configure()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firebase.getNumberOfImages()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! CustomTableViewCell
        
        firebase.getImage(fromURI: "gs://yummy-tummy-5bdc2.appspot.com")
        cell.recipeImage.image = firebase.image

        return cell
    }
}
