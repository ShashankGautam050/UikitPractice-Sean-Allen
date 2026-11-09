//
//  FollowersListVC.swift
//  UikitPractice
//
//  Created by Shashank Gautam on 24/09/26.
//

import UIKit



class FollowersListVC: UIViewController{
    nonisolated enum Section: Hashable, Sendable {
        case main
    }
    var userName : String!
    var page = 1
    var hasMoreFollowers = true
    var followers = [Follower]()
    var filteredFollowers = [Follower]()
    var uiCollectionView : UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configureViewController()
        configureCollectionView()
        configureDataSource()
        getFollowers(for: userName, for: page)
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
        uiCollectionView.delegate = self
        view.addSubview(uiCollectionView)
        uiCollectionView.backgroundColor = .systemBackground
        uiCollectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    func configureSearchController(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for an username..."
        navigationItem.searchController = searchController
    }
    func getFollowers(for userName : String,for page : Int){
        showLoadingView()
        NetworkManager.shared.getFollowers(for: userName, page: page) { [weak self] result in
            guard let self = self else { return }
            print("Network result received: \(result)")
            self.dismissLoadingView()
            switch result {
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false}
                self.followers.append(contentsOf: followers)
                if self.followers.isEmpty {
                    let message = "This user doesn't have any followers yet.💁🏾"
                    DispatchQueue.main.async {
                        self.showEmptyStateView(message: message, in: self.view)
                    }
                    return
                    
                }
                self.updateData(followers: self.followers)
                print("Followers count-> \(followers.count)")
                print(followers)
                
            case .failure(let error):
                print("Error fetching: \(error.rawValue)")
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
    
    
    func updateData(followers : [Follower]){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
        
    }
}

extension FollowersListVC : UICollectionViewDelegate{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        if offset > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(for: userName, for: page)
        }
    }
}


extension FollowersListVC : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text,!filter.isEmpty else { return }
        filteredFollowers = followers.filter{ $0.login.lowercased().contains(filter.lowercased())}
        updateData(followers: filteredFollowers)
    }
}

extension FollowersListVC : UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(followers: self.followers)
    }
}
