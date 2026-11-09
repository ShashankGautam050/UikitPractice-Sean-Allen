//
//  UPEmptyImageView.swift
//  UikitPractice
//
//  Created by Shashank Gautam on 07/11/26.
//

import UIKit

class UPEmptyStateView: UIView{
    let messageLabel = UPLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(message : String){
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    
   private func configure(){
       addSubview(messageLabel)
       addSubview(logoImageView)
       messageLabel.numberOfLines = 3
       messageLabel.translatesAutoresizingMaskIntoConstraints = false
       messageLabel.textColor = .secondaryLabel
       logoImageView.image = UIImage(named: "gh-logo")
       logoImageView.translatesAutoresizingMaskIntoConstraints = false
       
       NSLayoutConstraint.activate([
        messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
        messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
        messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
        messageLabel.heightAnchor.constraint(equalToConstant: 200),
        
        logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
        logoImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6),
        logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 150),
        logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 20)
        
       ])
    }
}
