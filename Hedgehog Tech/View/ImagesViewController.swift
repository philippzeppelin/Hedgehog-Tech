//
//  ImagesViewController.swift
//  Hedgehog Tech
//
//  Created by Philipp Zeppelin on 16.02.2023.
//

import UIKit

class ImagesViewController: UICollectionViewController, UISearchResultsUpdating {

    private var viewModel = [ImagesViewModel]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        navigationItem.searchController = searchController
        
        searchController.searchResultsUpdater = self
        
        APICaller.shared.getImages { [weak self] result in
            switch result {
            case .success(let images_results):
                self?.viewModel = images_results.compactMap({
                    ImagesViewModel(imageURL: URL(string: $0.original ?? "" ))
                })
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
    }
}

extension ImagesViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count  
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesCell.cellIdentifier, for: indexPath) as? ImagesCell else { fatalError() }
        cell.configure(with: viewModel[indexPath.row])
        return cell
    }

}
