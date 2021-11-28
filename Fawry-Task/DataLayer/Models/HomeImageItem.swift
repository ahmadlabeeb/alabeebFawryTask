//
//  HomeImageItem.swift
//  Fawry-Task
//
//  Created by Labeeb on 28/11/2021.
//

import Foundation

struct HomeImageItem: Codable {
    let id, author: String
    let width, height: Int
    let url, downloadURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}

