//
//  UPButton.swift
//  UikitPractice
//
//  Created by Shashank Gautam on 20/09/26.
//

import UIKit

class UPButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backGroundColor : UIColor,text : String) {
        super.init(frame: .zero)
        self.backgroundColor = backGroundColor
        self.setTitle(text, for: .normal)
        configure()
    }
    
    func configure(){
        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
