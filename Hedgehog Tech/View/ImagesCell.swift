//
//  ImagesCell.swift
//  Hedgehog Tech
//
//  Created by Philipp Zeppelin on 16.02.2023.
//

import UIKit

class ImagesCell: UICollectionViewCell {
    
    static let cellIdentifier = "cellIdentifier"
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(with ViewModel: ImagesViewModel) {
        if let data = ViewModel.imageData {
            imageView.image = UIImage(data: data)
        } else if let url = ViewModel.imageURL {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else { return }
                ViewModel.imageData = data
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
