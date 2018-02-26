//
//  CustomTableViewCell.swift
//  Yummy Tummy
//
//  Created by admin on 25/02/2018.
//  Copyright © 2018 Netanel Yeroshalmi. All rights reserved.
//

import UIKit

class CustomTableViewCell/*: UITableViewCell, UITableViewDataSource, UITableViewDelegate*/ {
    
    let firebase = FirebaseModel()
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    /*public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  //      let pic = firebase.getImageFromStorage(fromBucket: "StartMenuSprite.png")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }*/

}
