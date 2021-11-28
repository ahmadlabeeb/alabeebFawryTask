//
//  ImageCollectionViewCell.swift
//  Fawry-Task
//
//  Created by Labeeb on 28/11/2021.
//

import UIKit
import Kingfisher

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak  var auImageView: UIImageView!
    @IBOutlet weak  var auNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(auName: String, imageUrl: String) {
        auNameLabel.text = auName
        auImageView.fromUrlString(urlString: imageUrl)
    }
    
    func configureAsMoc() {
        auNameLabel.text = ""
        auImageView.image = UIImage.init(named: "moc-image")
    }


}

