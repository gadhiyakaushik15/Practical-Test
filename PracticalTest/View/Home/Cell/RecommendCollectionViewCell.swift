//
//  RecommendCollectionViewCell.swift
//  PracticalTest
//
//  Created by Tej Shah on 2022-05-09.
//

import UIKit

class RecommendCollectionViewCell: UICollectionViewCell {

    @IBOutlet var recommendLabel: UILabel!
    
    static let identifier = "RecommendCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        resizeTextElements()
        self.recommendLabel.text = localizationBundle.localizedString(forKey: "Recommended", value: "Recommended", table: nil)
    }

}
