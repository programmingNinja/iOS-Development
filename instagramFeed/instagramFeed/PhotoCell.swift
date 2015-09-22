//
//  PhotoCellTableViewCell.swift
//  instagramFeed
//
//  Created by Rohan Shah on 9/10/15.
//  Copyright (c) 2015 Rohan Shah. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
