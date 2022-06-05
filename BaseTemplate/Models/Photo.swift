//
//  Photo.swift
//  BaseTemplate
//
//  Created by @hellc on 05.06.2022.
//

import Foundation

struct Photo: Decodable {
    let albumId: Int
    let id: Int
    let title: String?
    let url: String?
    let thumbnailUrl: String?
}
