//
//  UIViewController+Ext.swift
//  UikitPractice
//
//  Created by Shashank Gautam on 26/09/26.
//

import UIKit

extension UIViewController{
    
    func presentAlertViewOnMainThread(titleLabel : String,message : String,buttonTitle : String){
        DispatchQueue.main.async {
            let alertVC = UIAlertVC(title: titleLabel, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
