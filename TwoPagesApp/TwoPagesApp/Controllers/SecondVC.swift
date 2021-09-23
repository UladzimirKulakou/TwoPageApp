//
//  SecondVC.swift
//  TwoPagesApp
//
//  Created by Uladzimir Kulakou on 9/20/21.
//

import UIKit
import Alamofire
import AlamofireImage

class SecondVC: UIViewController {
    var searchFromFirstVC: String?
    var data = [State]()
    var photos: [UnsplashPhoto] = []
    var urlAdresses: [String] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    //var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        guard let requestFromTF = searchFromFirstVC else { return }
        getData(by: requestFromTF)
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - функция вытаскивает из нашей модели нужный нам массив URL
    
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
    
    // MARK: - Функция которая делает запрос из полученного массива URL  на сервер и получает массив картинок
    
    func loadImages() {
        print("Count of URL: \(urlAdresses.count)")
        data = Array(repeating: .loading, count: urlAdresses.count)
        //  data = Array(repeating: .loading, count: 30)
        var index = 0
        for url in urlAdresses {
            AF.request(url).responseImage(queue: .global(qos: .utility)) { [unowned self] response in
                if case .success(let image) = response.result {
                    DispatchQueue.main.async() {
                        self.data[index] = .loaded(image: image)
                        self.collectionView.reloadData()
                        index += 1
                    }
                }
            }
            
        }
    }
}
// MARK: - сздаем ячейки через расширения

extension SecondVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellImage", for: indexPath) as! ImageCollectionViewCell
        cell.update(state: data[indexPath.row])
        return cell
    }
}

// MARK: - настраиваем размеры ячейки (три в ряду)

extension SecondVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameCV = collectionView.frame
        let widthCell = (frameCV.width / CGFloat(3)) - 2
        let hightCell = widthCell
        return CGSize(width: widthCell, height: hightCell)
    }
}
