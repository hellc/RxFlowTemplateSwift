//
//  AlbumsService.swift
//  BaseTemplate
//
//  Created by @hellc on 05.06.2022.
//

import Foundation

protocol HasAlbumsService {
    var albumsService: AlbumsService { get }
}

class AlbumsService {
    private let albumsApi = AlbumsApi()

    func albums() async throws -> [Album] {
        return try await self.albumsApi.albums()
    }

    func album(with id: Int) async throws -> Album {
        return try await self.albumsApi.album(with: id)
    }

    func photos(albumId: Int) async throws -> [Photo] {
        return try await self.albumsApi.photos(albumId: albumId)
    }
}
