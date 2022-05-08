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
    
    private let homeViewModel = HomeViewModel()
    private let marketCode = "UZ"
    private let productTagId = 13
    private var page = 1
    
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
        // Do any additional setup after loading the view.
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
