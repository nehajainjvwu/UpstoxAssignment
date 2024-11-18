//
//  CryptoListViewController.swift
//  Assignment
//
//  Created by Neha Jain on 14/11/2024.
//

import UIKit

class CryptoListViewController: UIViewController {
    
    let viewModel = CryptoCoinViewModel()
    var showSearch = false
    
    private let tableView = UITableView()
    let searchController = UISearchController(searchResultsController: nil)
    private var buttons: [UIButton] = []
    private var tableViewBottomConstraint: NSLayoutConstraint!
    
    var showFilter = false
    
    // Lazy initialization of the UICollectionView
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(FilterOptionCollectionViewCell.self, forCellWithReuseIdentifier: FilterOptionCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsMultipleSelection = true
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
        self.setupTableView()
        
        viewModel.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        getCoinFromAPI()
        self.view.backgroundColor = UIColor(named: "light_purple")
    }
    
    @objc
    func getCoinFromAPI() {
        viewModel.getCryptoCoin { isReponse in
            DispatchQueue.main.async {
                self.tableView.isHidden = !isReponse
                self.refershView(isTrue: !isReponse)
                if !isReponse {
                    self.showAlertMessage(title: "Oops", message: "Something went wrong. Please try again later.")
                }
            }
        }
    }
    
    private func setupNavigationBar () {
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "coin_purple")
        
        setupLeftBarItem()
        setupRightBarButtonItem()
    }
    
    private func setupLeftBarItem() {
        let barLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 120, height: 44))
        barLabel.text = "COIN"
        barLabel.font = UIFont.systemFont(ofSize: 19.0)
        barLabel.textColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: barLabel)
    }
    
    private func setupRightBarButtonItem() {
        let searchIcon = UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysOriginal)
        let searchButton = UIBarButtonItem(image: searchIcon, style: .plain, target: self, action: #selector(setupSearchController))
        searchButton.tintColor = .white
        
        let filterIcon = UIImage(named: "filter")
        let filterButton = UIBarButtonItem(image: filterIcon, style: .plain, target: self, action: #selector(self.setupCollectionView))
        filterButton.tintColor = .white
        
        self.navigationItem.setRightBarButtonItems([searchButton, filterButton], animated: true)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(CryptoCoinTableViewCell.self, forCellReuseIdentifier: CryptoCoinTableViewCell.identifier)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        tableViewBottomConstraint = tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0)
        tableViewBottomConstraint.isActive = true
    }
    
    //MARK: CollectionView UI Setup
    @objc
    private func setupCollectionView(sender: UIBarItem) {
        showFilter.toggle()
        setupCollectionViewLayout()
        
        // Animate layout changes
        UIView.animate(withDuration: 0.01) {
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: CollectionView LayoutSetup
    private func setupCollectionViewLayout() {
        if showFilter {
            tableViewBottomConstraint.constant = -150
            view.addSubview(collectionView)
            
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
                collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        } else {
            tableViewBottomConstraint.constant = 0
            collectionView.removeFromSuperview()
        }
    }
    
    //MARK: Method to reload the collection view on the main thread
    func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    @objc
    private func setupSearchController(sender: UIBarItem) {
        if showSearch {
            showSearch = false
            searchController.isActive = false
            searchController.dismiss(animated: true)
            navigationItem.searchController = nil
        } else {
            showSearch = true
            searchController.searchResultsUpdater = self
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.delegate = self
            searchController.searchBar.tintColor = .lightPurple
            searchController.searchBar.setPlaceholderColor(UIColor.lightGray)
            searchController.searchBar.showsCancelButton = false
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
            definesPresentationContext = true
            if showFilter {
                setupCollectionView(sender: UIBarItem())
            }
        }
    }
    
    //MARK: Alert View for Failure cases
    private func showAlertMessage(title: String, message: String) {
        let alertMessagePopUpBox = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alertMessagePopUpBox.addAction(okButton)
        self.present(alertMessagePopUpBox, animated: true)
    }
}

