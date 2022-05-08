//
//  AppLoader.swift
//  PracticalTest
//
//  Created by Ankur Kathiriya on 04/05/22.
//

import UIKit
import MBProgressHUD
import SDWebImage


class AppLoader: NSObject {
    static var sharedInstance = AppLoader()
    func startLoader(){
        let path = Bundle.main.path(forResource: "loader", ofType: "gif")
        do {
            let screenWidth = UIScreen.main.bounds.width
            let height = (screenWidth / 375) * 125
            let imageData = try Data(contentsOf: URL.init(fileURLWithPath: path!))
            let gifImageView = UIImageView.init(image: UIImage.sd_image(withGIFData: imageData))
            gifImageView.frame = CGRect(x: 0, y: 0, width: height, height: height)
            let view = customLoaderView()
            view.backgroundColor = .clear
            view.addSubview(gifImageView)
            
            let hud = MBProgressHUD.showAdded(to: appDelegate.window!, animated: true)
            hud.customView = view
            hud.mode = .customView
            hud.backgroundView.style = .solidColor
            hud.backgroundView.color = UIColor.black.withAlphaComponent(0.5)
            hud.bezelView.color = UIColor.clear
            hud.bezelView.style = .solidColor
        } catch {
            // print("Error loading image : \(error)")
        }
    }
    
    func stopLoader() {
        MBProgressHUD.hide(for: appDelegate.window!, animated: true)
    }
}

class customLoaderView: UIView {
    override var intrinsicContentSize: CGSize {
        get {
            let screenWidth = UIScreen.main.bounds.width
            let height = (screenWidth / 375) * 125
            return CGSize(width: height, height: height)
        }
    }
}
