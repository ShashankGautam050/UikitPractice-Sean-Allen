//
//  FollowersListVC.swift
//  UikitPractice
//
//  Created by Shashank Gautam on 24/09/26.
//

import UIKit



class FollowersListVC: UIViewController {
    nonisolated enum Section: Hashable, Sendable {
        case main
    }
    var userName : String!
    var followers = [Follower]()
    var uiCollectionView : UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers()
        configureDataSource()
    }
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureCollectionView(){
        uiCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(uiCollectionView)
        uiCollectionView.backgroundColor = .systemBrown
        uiCollectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }

    func getFollowers(){
        
        NetworkManager.shared.getFollowers(for: userName ?? "", page: 1) { [weak self] result in
            guard let self = self else { return } 
            switch result {
            case .success(let followers):
                self.followers = followers
                self.updateData()
                print("Followers count-> \(followers.count)")
                print(followers)
                
            case .failure(let error):
                self.presentAlertViewOnMainThread(titleLabel: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "Okay")
            }
        }
    }
    
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: uiCollectionView, cellProvider: { [weak self] collectionView, indexPath, follower in
            let cell = self?.uiCollectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    
    func updateData(){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
        
    }
    

  

}
