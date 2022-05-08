//
//  SplashViewController.swift
//  PracticalTest
//
//  Created by Tej Shah on 2022-05-08.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.showStartScreen()
        // Do any additional setup after loading the view.
    }
    
    func showStartScreen() {
        NavigationManager.setRootViewControllerWithNavigation(controller: self.getViewController(storyboard: Storyboard.home, id: "HomeViewController"))
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
