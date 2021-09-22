//
//  ImageCollectionViewCell.swift
//  TwoPagesApp
//
//  Created by Uladzimir Kulakou on 9/21/21.
//

import UIKit

// MARK: - Создаем enum для заполнения массива базисного для создания ячеек делаем это именно ток, потому что хотим корректно отобразить индикатор загрузки

enum State {
    case loading
    case loaded(image: UIImage)
}

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 7
        // Initialization code
    }
    func update(state: State) {
        switch state {
        case .loading:
            if !activityIndicator.isAnimating {
                activityIndicator.startAnimating()
            }
            photoView.image = nil
        case let .loaded(image: image):
            if activityIndicator.isAnimating {
                activityIndicator.stopAnimating()
            }
            photoView.image = image
        }
    }
}
