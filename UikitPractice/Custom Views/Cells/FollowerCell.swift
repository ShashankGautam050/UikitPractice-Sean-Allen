//
//  FollowerCell.swift
//  UikitPractice
//
//  Created by Shashank Gautam on 23/10/26.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    static let reuseID = "FollowerCell"
    
    let avatarImageView = UPAvatarImageView(frame: .zero)
    let usernameLabel = UPLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func set(follower : Follower){
        usernameLabel.text = follower.login
         avatarImageView.downloadImage(for: follower.avatarUrl)
        
    }
    
    private func configure(){
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
        let padding: CGFloat  = 8
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: padding),
            usernameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
