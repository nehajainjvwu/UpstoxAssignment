//
//  ExtensionCryptoListViewController.swift
//  Assignment
//
//  Created by Neha Jain on 17/11/24.
//

import UIKit

//MARK: TableView DataSource
extension CryptoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredCoinsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CryptoCoinTableViewCell.identifier, for: indexPath) as? CryptoCoinTableViewCell {
            cell.configure(with: viewModel.filteredCoinsArray[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

//MARK: UICollectionView Delegate, DataSource and FlowLayout
extension CryptoListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Return the number of items in the collection view section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filters.count
    }
    
    // Configure and return the cell for a given index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterOptionCollectionViewCell.identifier, for: indexPath) as! FilterOptionCollectionViewCell
        
        var isSelected = false
        
        if viewModel.selectedItems.contains(indexPath) {
            isSelected = true
        }
        
        cell.configure(with: viewModel.filters[indexPath.row], isSelected: isSelected)
        
        return cell
    }
    
    // Return the size for the item at a given index path
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Calculate title size
        let titleSize = (viewModel.filters[indexPath.item].name as NSString).size(withAttributes: [ .font: UIFont.systemFont(ofSize: 14) ])
        // Adjust button width
        let buttonWidth = titleSize.width + 30
        
        return CGSize(width: buttonWidth, height: 38)
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedFilter = viewModel.filters[indexPath.item]
        // Find and remove a filter by name
        if let index = viewModel.selectedFilters.firstIndex(where: { $0.name == selectedFilter.name }) {
            viewModel.selectedFilters.remove(at: index)
        } else {
            viewModel.selectedFilters.append(selectedFilter)
        }
        if viewModel.selectedItems.contains(indexPath){
            viewModel.selectedItems.remove(indexPath)
        } else {
            viewModel.selectedItems.insert(indexPath)
        }
        
        if viewModel.selectedItems.count > 0 {
            viewModel.filterCoins()
        } else {
            viewModel.cancelSearch()
        }
        
        collectionView.reloadData()
    }
}

extension CryptoListViewController: UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    /// Update the Search result and Reload the Table
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchBar.showsCancelButton = true
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            viewModel.searchText = searchText
            viewModel.searchCoin()
        } else {
            viewModel.cancelSearch()
        }
    }
    
    /// Search Bar Cancel Button Clicked
    /// Remove Search Controller & disable search
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        showSearch = false
        searchBar.showsCancelButton = false
        if self.searchController.isActive {
            self.searchController.isActive = false
        }
        self.navigationItem.searchController = nil
    }
}

/// Refresh Button Funcationality
extension CryptoListViewController {
    
    func refershView(isTrue: Bool) {
        let refreshButton = UIButton()
        if isTrue {
            refreshButton.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
            refreshButton.tintColor = .white
            refreshButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            refreshButton.setTitle(" Refresh ", for: .normal)
            refreshButton.addTarget(self, action: #selector(getCoinFromAPI), for: .touchUpInside)
            view.addSubview(refreshButton)
            
            setupLayoutForRefreshButton(refreshButton: refreshButton)
        } else {
            refreshButton.removeFromSuperview()
        }
    }
    
    func setupLayoutForRefreshButton(refreshButton: UIButton) {
        let centerX = NSLayoutConstraint(item: refreshButton, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: refreshButton, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: refreshButton, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 44)
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([centerX, centerY, height])
    }
    
}
