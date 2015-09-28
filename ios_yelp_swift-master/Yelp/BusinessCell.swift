//
//  BusinessCell.swift
//  Yelp
//
//  Created by Rohan Shah on 9/22/15.
//  Copyright (c) 2015 Rohan Shah. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var ratingsImageView: UIImageView!
    @IBOutlet weak var reviewCountLabel: UILabel!
    
    
    var business: Business! {
        didSet {
            nameLabel.text = business.name
            thumbnailImageView.setImageWithURL(business.imageURL)
            reviewCountLabel.text = "\(business.reviewCount!.stringValue) reviews"
            addressLabel.text = business.address
            distanceLabel.text = business.distance
            ratingsImageView.setImageWithURL(business.ratingImageURL)
            categoriesLabel.text = business.categories
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thumbnailImageView.layer.cornerRadius = 5
        thumbnailImageView.clipsToBounds = true
            }

   
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
