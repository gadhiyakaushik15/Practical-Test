//
//  BannerCollectionReusableView.swift
//  PracticalTest
//
//  Created by Tej Shah on 2022-05-08.
//

import UIKit
import ImageSlideshow

class BannerCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var imageSlider_View: ImageSlideshow!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    // MARK: - UI Config
    func configureUI() {
        let pageIndicator = UIPageControl()
        pageIndicator.currentPageIndicatorTintColor = UIColor.white
        pageIndicator.pageIndicatorTintColor = UIColor.black
        self.imageSlider_View.pageIndicator = pageIndicator
        self.imageSlider_View.pageIndicatorPosition = PageIndicatorPosition(horizontal: .center, vertical: .under)
        self.imageSlider_View.activityIndicator = DefaultActivityIndicator(style: .large)
        self.imageSlider_View.contentScaleMode = .scaleAspectFill
        self.imageSlider_View.slideshowInterval = 2.0
    }
}
