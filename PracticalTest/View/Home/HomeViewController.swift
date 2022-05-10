//
//  HomeViewController.swift
//  PracticalTest
//
//  Created by Ankur Kathiriya on 04/05/22.
//

import UIKit
import ImageSlideshow
import SDWebImage

class HomeViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    
    private let homeViewModel = HomeViewModel()
    private let marketCode = "UZ"
    private var productTagId = 0
    private var page = 1
    private let refreshControl = UIRefreshControl.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    private var bannerData: BannerModel?
    private var productListData: ProductListModel?
    private var marketList = [MarketList]()
    private var pagination: Pagination?
    
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
        
        self.homeViewModel.getHomeBanner(marketCode: marketCode) { data in
            self.bannerData = data
            if let productTagId = self.bannerData?.data?.recommended?.productTagID {
                self.productTagId = productTagId
                self.homeViewModel.getProductList(page: self.page, productTagId: self.productTagId, marketCode: self.marketCode) {data in
                    self.productListData = data
                    if let data = self.productListData?.data, let marketList = data.marketList, let pagination = data.pagination {
                        self.marketList = marketList
                        self.pagination = pagination
                    }
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Pagination trigger
    @objc func paginationMore() {
        if self.productListData != nil, let pagination = self.pagination, let totalPage = pagination.totalPage {
            if self.page < totalPage {
                page += 1
                self.homeViewModel.getProductList(page: self.page, productTagId: self.productTagId, marketCode: self.marketCode) {data in
                    self.productListData = data
                    if let data = self.productListData?.data, let marketList = data.marketList, let pagination = data.pagination {
                        self.marketList.append(contentsOf: marketList)
                        self.pagination = pagination
                    }
                    self.refreshControl.endRefreshing()
                    self.collectionView.reloadData()
                }
            } else {
                self.refreshControl.endRefreshing()
                self.collectionView.reloadData()
            }
        } else {
            self.refreshControl.endRefreshing()
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
            if let bannerData = self.bannerData, let data = bannerData.data, let mainBanner = data.mainBanner {
                for banner in mainBanner {
                    if let urlStr = banner.imageURL {
                        if let imageUrl = SDWebImageSource(urlString: urlStr, placeholder: UIImage()) {
                             imageUrls.append(imageUrl)
                         }
                    }
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
        if marketList.count > 0 {
            return marketList.count + 1
        } else {
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCollectionViewCell.identifier, for: indexPath)as! RecommendCollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath)as! ProductCollectionViewCell
            let index = indexPath.row - 1
            let list = marketList[index]
            cell.productImageView.sd_setImage(with: URL(string: list.imgURL ?? ""), placeholderImage: UIImage(named: "ic_placeholder"))
            cell.productNameLabel.text = list.name ?? ""
            if let price = list.localPrice {
            cell.productPriceLabel.text = Utilities.sharedInstance.ConvertNumberToCurrencyFormat(number: price)
            } else {
                cell.productPriceLabel.text = ""
            }
            if let rank = list.rank, rank >= 1 {
                cell.productRateView.isHidden = false
                cell.productRateView.alpha = 1.0
                cell.productRateLabel.text = "\(rank)"
            } else {
                cell.productRateView.isHidden = true
                cell.productRateView.alpha = 0.0
            }
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
            return CGSize(width: width, height: width * 1.6)
        }
    }
    
}
