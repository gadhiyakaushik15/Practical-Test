//
//  ProductCollectionViewCell.swift
//  PracticalTest
//
//  Created by Tej Shah on 2022-05-08.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productRateView: UIView!
    @IBOutlet weak var productRateLabel: UILabel!
    
    static let identifier = "ProductCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
