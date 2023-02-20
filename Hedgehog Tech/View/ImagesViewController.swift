//
//  ImagesViewController.swift
//  Hedgehog Tech
//
//  Created by Philipp Zeppelin on 16.02.2023.
//

import UIKit

class ImagesViewController: UICollectionViewController, UISearchResultsUpdating {

    private var viewModel = [ImagesViewModel]()
    
    let searchVC = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Hedgehog Tech"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance

        
        fetchImages()
        createSearchBar()
    }

    private func createSearchBar() {
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
    }
    
    private func fetchImages() {
        APICaller.shared.getImages { [weak self] result in
            switch result {
            case .success(let images_results):
                self?.viewModel = images_results.compactMap({
                    ImagesViewModel(imageURL: URL(string: $0.original))
                })
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
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

extension ImagesViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        print(text)
        
        APICaller.shared.searchImages(with: text) { [weak self] result in
            switch result {
            case .success(let images_results):
                self?.viewModel = images_results.compactMap({
                    ImagesViewModel(imageURL: URL(string: $0.original))
                })
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}
