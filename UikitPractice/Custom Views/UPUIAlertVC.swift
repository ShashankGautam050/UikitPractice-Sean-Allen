//
//  UIAlertVC.swift
//  UikitPractice
//
//  Created by Shashank Gautam on 24/09/26.
//

import UIKit

class UIAlertVC: UIViewController {
    let containerView = UIView()
    let labelTitle = UPLabel(textAlignment: .center, fontSize: 20)
    let labelBody = UPLabelBody(textAlignment: .center)
    let actionButton =  UPButton(backGroundColor: .systemPink, text: "OK")
    let padding : CGFloat = 20
    var alertTitle : String?
    var message : String?
    var buttonTitle : String?
    
    init(title : String,message : String,buttonTitle : String){
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureContainerView()
        configureCallToAction()
        configureTitleLabel()
        configureBodyLevel()
        
        

        
    }
    
    
    func configureContainerView(){
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.layer.borderWidth = 2
        containerView.layer.cornerRadius = 16
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 220),
            containerView.widthAnchor.constraint(equalToConstant: 280)
        ])
    }
    
    
    func configureTitleLabel(){
        containerView.addSubview(labelTitle)
        labelTitle.text = alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            labelTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            labelTitle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            labelTitle.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func configureCallToAction(){
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "OK", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding)
        ])
    }
    
    func configureBodyLevel(){
        containerView.addSubview(labelBody)
        labelBody.text = message ?? "Unable to make request"
        labelBody.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            labelBody.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            labelBody.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 10),
            labelBody.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            labelBody.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -padding)
            
        ])
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    

}
