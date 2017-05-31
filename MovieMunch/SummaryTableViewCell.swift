//
//  SummaryTableViewCell.swift
//  MovieMunch
//
//  Created by Anil Kumar on 25/05/17.
//  Copyright © 2017 INDCG. All rights reserved.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {
    @IBOutlet var Name: UILabel!
    @IBOutlet var Price: UILabel!
    @IBOutlet var FoodImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
