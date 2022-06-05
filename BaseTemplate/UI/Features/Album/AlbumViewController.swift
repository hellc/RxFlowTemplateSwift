//
//  AlbumViewController.swift
//  BaseTemplate
//
//  Created by @hellc on 05.06.2022.
//

import UIKit
import Reusable
import RxFlow
import RxSwift

class AlbumViewController: UIViewController, StoryboardBased, ViewModelBased {
    private let disposeBag = DisposeBag()

    @IBOutlet private weak var collectionView: UICollectionView!

    var viewModel: AlbumViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.register(cellType: PhotoCollectionViewCell.self)

        self.viewModel.photosSubject
            .bind(to: self.collectionView.rx.items(
                cellIdentifier: "PhotoCollectionViewCell",
                cellType: PhotoCollectionViewCell.self
            )) { _, photo, cell in
                cell.configure(with: photo)
            }.disposed(by: self.disposeBag)

        self.viewModel.loadPhotos()
    }
}
