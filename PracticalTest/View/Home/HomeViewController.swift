//
//  HomeViewController.swift
//  PracticalTest
//
//  Created by Ankur Kathiriya on 04/05/22.
//

import UIKit
import ImageSlideshow

class HomeViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    
    private let homeViewModel = HomeViewModel()
    private let marketCode = "UZ"
    private let productTagId = 13
    private var page = 1
    private let randomPhotos = ["https://cdn.pixabay.com/photo/2022/04/23/20/51/nature-7152461_1280.jpg", "https://cdn.pixabay.com/photo/2022/04/23/20/51/nature-7152461_1280.jpg", "https://cdn.pixabay.com/photo/2022/04/23/20/51/nature-7152461_1280.jpg", "https://cdn.pixabay.com/photo/2022/04/23/20/51/nature-7152461_1280.jpg"]
    private var productList = 10
    private let refreshControl = UIRefreshControl.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.resizeTextElements()
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        self.searchBar.textField?.textColor = .searchBarText
        self.searchBar.textField?.font = adjustedFontForScreenSize(.workSans(family: .regular, size: 15))
        self.searchBar.barTintColor = .searchBarTint
        self.searchBar.textField?.backgroundColor = .whiteBackground
        self.searchBar.placeholder = localizationBundle.localizedString(forKey: "SearchForProducts", value: "Search for products", table: nil)
        
        self.collectionView.register(UINib(nibName: BannerCollectionReusableView.identifier, bundle: .main), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: BannerCollectionReusableView.identifier)
        self.collectionView.register(UINib(nibName: RecommendCollectionViewCell.identifier, bundle: .main), forCellWithReuseIdentifier: RecommendCollectionViewCell.identifier)
        self.collectionView.register(UINib(nibName: ProductCollectionViewCell.identifier, bundle: .main), forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        
        refreshControl.triggerVerticalOffset = 50.0
        refreshControl.addTarget(self, action: #selector(paginationMore), for: .valueChanged)
        self.collectionView.bottomRefreshControl = refreshControl
    }
    
    // MARK: - Pagination trigger
    @objc func paginationMore() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            self.refreshControl.endRefreshing()
            self.productList += 6
            self.collectionView.reloadData()
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // MARK: CollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableView = UICollectionReusableView()
        if (kind == UICollectionView.elementKindSectionHeader) {
            let bannerReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: BannerCollectionReusableView.identifier, for: indexPath) as! BannerCollectionReusableView

             bannerReusableView.frame = CGRect(x: 0 , y: 0, width: collectionView.frame.width, height: 230)
             var imageUrls = [InputSource]()
             for randomPhoto in randomPhotos {
                 if let imageUrl = SDWebImageSource(urlString: randomPhoto, placeholder: UIImage()) {
                     imageUrls.append(imageUrl)
                 }
             }
            bannerReusableView.imageSlider_View.setImageInputs(imageUrls)
            reusableView = bannerReusableView
        }
        return reusableView
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList + 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCollectionViewCell.identifier, for: indexPath)as! RecommendCollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath)as! ProductCollectionViewCell
            return cell
        }
    }
    
    // MARK: CollectionView Delegate FlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 230)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: collectionView.frame.width, height: 20)
        } else {
            let width = (collectionView.frame.width - 30) / 2
            return CGSize(width: width, height: width)
        }
    }
    
}
