//
//  ImageCollectionViewCell.swift
//  TwoPagesApp
//
//  Created by Uladzimir Kulakou on 9/21/21.
//

import UIKit


enum State {
    case loading
    case loaded(image: UIImage)
}

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
//    var unsplashPhoto: UnsplashPhoto! {
//        didSet {
//            let photoUrl = unsplashPhoto.urls["regular"]
//            guard let imageUrl = photoUrl, let url = URL(string: imageUrl) else { return }
//        }
//    }
    override func awakeFromNib() {
        super .awakeFromNib()
        
        activityIndicator.isHidden = false
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
                activityIndicator.isHidden = true
            }
            photoView.image = image
        }
    }
    
    
    
    
    
}
