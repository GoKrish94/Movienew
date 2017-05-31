//
//  TheatreTableViewCell.swift
//  MovieMunch
//
//  Created by Anilkumar Achuthan unni on 23/05/17.
//  Copyright © 2017 INDCG. All rights reserved.
//

import UIKit

class TheatreTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
