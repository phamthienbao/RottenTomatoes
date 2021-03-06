//
//  MoviesCell.swift
//  RottenTomatoes
//
//  Created by Bao Pham on 8/30/15.
//  Copyright © 2015 Bao Pham. All rights reserved.
//

import UIKit

class MoviesCell: UITableViewCell {

    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var posterThumb: UIImageView!
        @IBOutlet weak var descMovie: UILabel!
    @IBOutlet weak var networkError: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
