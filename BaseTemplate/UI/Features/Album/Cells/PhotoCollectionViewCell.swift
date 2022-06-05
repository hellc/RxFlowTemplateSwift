//
//  PhotoCollectionViewCell.swift
//  BaseTemplate
//
//  Created by @hellc on 05.06.2022.
//

import UIKit
import Reusable
import CatalystNet

class PhotoCollectionViewCell: UICollectionViewCell, NibReusable {
    @IBOutlet weak var previewImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with photo: Photo) {
        Task.init {
            guard let thumbnailUrlString = photo.thumbnailUrl,
                  let url = URL(string: thumbnailUrlString) else {
                // Proceed error
                return
            }

            let task = URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data else { return }
                let imageFromData = UIImage(data: data)
                DispatchQueue.main.async {
                    self.previewImageView.image = imageFromData
                }
            }
            task.resume()
        }
    }
}
