//
//  AlbumCollectionViewCell.swift
//  BaseTemplate
//
//  Created by @hellc on 05.06.2022.
//

import UIKit
import Reusable

class AlbumCollectionViewCell: UICollectionViewCell, NibReusable {
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!

    func configure(with album: Album) {
        self.descLabel.text = "\(album.id)"
    }
}
