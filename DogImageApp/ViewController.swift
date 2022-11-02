//
//  ViewController.swift
//  DogImageApp
//
//  Created by tetsuya on 2022/10/30.
//

import UIKit
import Alamofire
import Kingfisher



struct dogApiResponce: Codable {
    let message: String
    let status: String
}

class ViewController: UIViewController {
    
    var dogImages: [dogApiResponce] = []
    
    @IBOutlet weak var dogImageView: UIImageView!
    
    @IBAction func reloadDogs(_ sender: Any) {
        // print("更新ボタンのテスト")
        getDogPhotos()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDogPhotos()
    }
    
    
    func getDogPhotos() {
        
        AF.request(
            Constants.shared.dogUrl
        ).responseDecodable(of:dogApiResponce.self) { response in
            
            switch response.result {
            case .success(let value):
                // print(value.message)
                // print(value.status)
                let photoUrl = URL(string: value.message)!
                self.dogImageView.kf.setImage(with: photoUrl)
                
            case .failure(let error):
                print("error", error)
            }
        }
    }
    
}
