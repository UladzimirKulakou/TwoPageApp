//
//  FirstVC.swift
//  TwoPagesApp
//
//  Created by Uladzimir Kulakou on 9/19/21.
//

import UIKit

class FirstVC: UIViewController {
    
    // MARK: - создаем Outlet  для элементов в StackView
    
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // MARK: - закругляем кнопку
        
        button.layer.cornerRadius = 5
    }
    
    // MARK: - Передаем информацию из TextField на второй контроллер, segue не именуем, т.к. у нас тут всего один переход
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! SecondVC
        destination.searchFromFirstVC = searchTF.text
        searchTF.text = nil
    }


}
