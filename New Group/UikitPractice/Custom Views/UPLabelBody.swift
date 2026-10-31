//
//  UPLabelBody.swift
//  UikitPractice
//
//  Created by Shashank Gautam on 24/09/26.
//

import UIKit

class UPLabelBody: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment : NSTextAlignment){
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        
        configure()
    }
    
    private  func configure(){
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        font = UIFont.preferredFont(forTextStyle: .body)
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints =  false
    }
}
