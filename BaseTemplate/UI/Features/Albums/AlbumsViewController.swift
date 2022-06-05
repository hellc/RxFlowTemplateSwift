//
//  AlbumsViewController.swift
//  BaseTemplate
//
//  Created by @hellc on 05.06.2022.
//

import UIKit
import Reusable
import RxFlow
import RxSwift

class AlbumsViewController: UIViewController, StoryboardBased, ViewModelBased {
    private let disposeBag = DisposeBag()

    @IBOutlet private weak var collectionView: UICollectionView!

    var viewModel: AlbumsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.register(cellType: AlbumCollectionViewCell.self)

        self.viewModel.albumsSubject
            .bind(to: self.collectionView.rx.items(
                    cellIdentifier: "AlbumCollectionViewCell",
                    cellType: AlbumCollectionViewCell.self
            )) { _, album, cell in
                cell.configure(with: album)
            }.disposed(by: self.disposeBag)

        self.viewModel.loadAlbums()

        self.collectionView.rx.modelSelected(Album.self)
            .subscribe(onNext: { album in
                self.viewModel.pick(albumId: album.id)
            })
            .disposed(by: self.disposeBag)
    }
}
