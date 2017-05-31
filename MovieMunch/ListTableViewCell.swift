//
//  ListTableViewCell.swift
//  MovieMunch
//
//  Created by Anil Kumar on 17/05/17.
//  Copyright © 2017 INDCG. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet var imageview: UIImageView!
    @IBOutlet var NameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet var PriceLabel: UILabel!
    @IBOutlet var removelabel: UIButton!
    @IBAction func remove(_ sender: AnyObject) {
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
