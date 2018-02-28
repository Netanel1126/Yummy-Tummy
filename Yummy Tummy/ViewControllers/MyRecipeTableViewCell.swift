import UIKit

class MyRecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeImg: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
