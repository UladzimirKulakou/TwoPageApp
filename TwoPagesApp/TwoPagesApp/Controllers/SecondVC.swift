//
//  SecondVC.swift
//  TwoPagesApp
//
//  Created by Uladzimir Kulakou on 9/20/21.
//

import UIKit

class SecondVC: UIViewController {
    var searchFromFirstVC: String?
    
    var photos: [UnsplashPhoto] = []
    var urlAdresses: [String] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        getData(by: searchFromFirstVC!)
        
        // Do any additional setup after loading the view.
    }
    
    func getData(by search: String) {
        let networkDataFetcher = NetworkDataFetcher()
        networkDataFetcher.getImages(searchTerm: search) {[weak self](searchRasults) in
            guard let featchedPhotos = searchRasults,
                  let self = self else { return }
            for element in featchedPhotos.results {
                guard let url = element.urls[URLKing.regular.rawValue] else { return }
                self.urlAdresses.append(url)
                print("Adress: \(String(describing: self.urlAdresses))")
            }
            self.loadImages()
            self.collectionView.reloadData()
        }
    }
    
    func loadImages() {
        for url in urlAdresses {
            if let data = try? Data(contentsOf: URL(string: url)!),
               let image = UIImage(data: data) {
                images.append(image)
            }
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension SecondVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellImage", for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        let image = images[indexPath.item]
        cell.photoView.image = image
        
        return cell 
    }
}

extension SecondVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameCV = collectionView.frame
        let widthCell = (frameCV.width / CGFloat(3)) - 2
        let hightCell = widthCell
        return CGSize(width: widthCell, height: hightCell)
    }
}
