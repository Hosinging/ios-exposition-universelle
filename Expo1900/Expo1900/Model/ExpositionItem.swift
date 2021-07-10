//
//  ExpositionItem.swift
//  Expo1900
//
//  Created by EHD, Hosinging on 2021/07/07.
//

import Foundation

struct ExpositionItem: Codable {
    let items: [Item]
}

struct Item: Codable {
    let name: String
    let imageName: String
    let shortDescription: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case imageName = "image_name"
        case shortDescription = "short_description"
        case description = "desc"
    }
}