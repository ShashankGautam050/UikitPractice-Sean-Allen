//
//  FollowersListVC.swift
//  UikitPractice
//
//  Created by Shashank Gautam on 24/09/26.
//

import UIKit

class FollowersListVC: UIViewController {
    var userName : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
  

}
