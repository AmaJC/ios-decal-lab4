//
//  CustomTableViewCell.swift
//  PokedexLab
//
//  Created by JC Dy on 3/7/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var pokeName: UILabel!
    @IBOutlet weak var pokeNum: UILabel!
    @IBOutlet weak var pokeStats: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
