//
//  ImagesData.swift
//  Hedgehog Tech
//
//  Created by Philipp Zeppelin on 17.02.2023.
//

import Foundation

struct APIResponce: Codable {
    let images_results: [Images]
}

struct Images: Codable {
    let original: String
    let link: String
}
