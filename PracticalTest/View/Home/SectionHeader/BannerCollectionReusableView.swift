//
//  BannerCollectionReusableView.swift
//  PracticalTest
//
//  Created by Tej Shah on 2022-05-08.
//

import UIKit
import ImageSlideshow

class BannerCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var imageSliderView: ImageSlideshow!
    
    static let identifier = "BannerCollectionReusableView"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    // MARK: - UI Config
    func configureUI() {
        let pageIndicator = UIPageControl()
        pageIndicator.currentPageIndicatorTintColor = .navigationBarBackground
        pageIndicator.pageIndicatorTintColor = .navigationBarTitle
        self.imageSliderView.pageIndicator = pageIndicator
        self.imageSliderView.activityIndicator = DefaultActivityIndicator(style: .large)
        self.imageSliderView.contentScaleMode = .scaleAspectFill
        self.imageSliderView.slideshowInterval = 2.0
    }
}
