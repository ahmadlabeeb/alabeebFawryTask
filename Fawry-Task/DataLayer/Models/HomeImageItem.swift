//
//  HomeImageItem.swift
//  Fawry-Task
//
//  Created by Labeeb on 28/11/2021.
//

import Foundation
import RxSwift

struct HomeImageItem: Codable {
    let id: String
    let author: String
    let isMocImage: Bool?
    let width:Int?
    let height: Int?
    let url: String?
    let downloadURL: String
    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url,isMocImage
        case downloadURL = "download_url"
    }
}

