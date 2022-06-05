//
//  ApiService.swift
//  BaseTemplate
//
//  Created by @hellc on 05.06.2022.
//

import Foundation

protocol HasPhotosService {
    var photosService: PhotosService { get }
}

class PhotosService {
    private let photosApi = PhotosApi()

    func photo(with id: Int) async throws -> Photo {
        return try await self.photosApi.photo(with: id)
    }
}
