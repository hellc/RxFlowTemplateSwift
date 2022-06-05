//
//  AlbumViewModel.swift
//  BaseTemplate
//
//  Created by @hellc on 05.06.2022.
//

import RxFlow
import RxSwift
import RxCocoa

class AlbumViewModel: ServicesViewModel, Stepper {
    typealias Services = HasAlbumsService

    public let albumId: Int

    init(albumId id: Int) {
        self.albumId = id
    }

    private(set) var photosSubject = PublishSubject<[Photo]>()

    let steps = PublishRelay<Step>()

    var services: Services!

    func loadPhotos() {
        Task.init {
            let photos = try await self.services.albumsService.photos(albumId: self.albumId)
            self.photosSubject.onNext(photos)
        }
    }

    public func pick(photoId: Int) {
        self.steps.accept(AppStep.photoIsPicked(photoId: photoId))
    }
}
