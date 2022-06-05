//
//  AlbumsViewModel.swift
//  BaseTemplate
//
//  Created by @hellc on 05.06.2022.
//

import RxFlow
import RxSwift
import RxCocoa

class AlbumsViewModel: ServicesViewModel, Stepper {
    typealias Services = HasAlbumsService

    private(set) var albumsSubject = PublishSubject<[Album]>()

    let steps = PublishRelay<Step>()

    var services: Services!

    func loadAlbums() {
        Task.init {
            let albums = try await self.services.albumsService.albums()
            self.albumsSubject.onNext(albums)
        }
    }

    public func pick(albumId: Int) {
        self.steps.accept(AppStep.albumIsPicked(albumId: albumId))
    }
}
