//
//  ImagesViewModel.swift
//  Hedgehog Tech
//
//  Created by Philipp Zeppelin on 18.02.2023.
//

import Foundation

class ImagesViewModel {
    let imageURL: URL? 
    var imageData: Data? = nil
    
    init(imageURL: URL?, imageData: Data? = nil) {
        self.imageURL = imageURL
        self.imageData = imageData
    }
}

