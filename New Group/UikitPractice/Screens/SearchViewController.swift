//
//  SearchViewController.swift
//  UikitPractice
//
//  Created by Shashank Gautam on 20/09/26.
//

import UIKit

class SearchViewController: UIViewController {
    let logoImageView = UIImageView()
    let userNameTextfield = UPTextField()
    let callToAction = UPButton(backGroundColor: .systemGreen, text: "Get Followers")
    var isUserName : Bool {
        return !(userNameTextfield.text?.isEmpty == nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configurelogoImageView()
        configureTextField()
        configureButton()
        createKeyboarDismiss()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    func createKeyboarDismiss(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func pushFollowersListVC(){
        guard isUserName else {
            debugPrint("no username")
            presentAlertViewOnMainThread(titleLabel: "Empty Username", message: "Please enter your username we want to know whom  to look 😀", buttonTitle: "OK")
            return
        }
        let followersListVC = FollowersListVC()
        followersListVC.userName = userNameTextfield.text
        followersListVC.title = userNameTextfield.text
        navigationController?.pushViewController(followersListVC, animated: true)
    }
    func configurelogoImageView(){
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")!
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField(){
        view.addSubview(userNameTextfield)
        userNameTextfield.delegate = self
        NSLayoutConstraint.activate([
            userNameTextfield.topAnchor.constraint(equalTo: logoImageView.bottomAnchor,constant: 50),
            userNameTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userNameTextfield.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureButton(){
        view.addSubview(callToAction)
        callToAction.addTarget(self, action: #selector(pushFollowersListVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            callToAction.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -50),
            callToAction.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToAction.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToAction.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension SearchViewController : UITextFieldDelegate{
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        pushFollowersListVC()
        debugPrint("did button clicked")
        return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowersListVC()
        return true
    }
}

