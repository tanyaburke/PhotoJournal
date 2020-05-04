//
//  ViewController.swift
//  PhotoJournalApp
//
//  Created by Tanya Burke on 2/18/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    var images = [UIImage]() {
        didSet {
            imageCollectionView.reloadData()
        }
    }
      private var imageObjects = [ImageObject]()
    private let imagePickerController = UIImagePickerController()
    
     private let dataPersistence = PersistenceHelper(filename: "images.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        
    }
    
    


}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let maxWidth: CGFloat = UIScreen.main.bounds.size.width
    let itemWidth: CGFloat = maxWidth * 0.80
    return CGSize(width: itemWidth, height: itemWidth)  }
    
}



extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return images.count
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCell else {
            fatalError("Was expecting an CollectionViewCell, but found a different type")
        }
//        let image = images[indexPath.row]
//          cell.configureCell(imageObject: image)
//        cell.delegate = self
        return cell
    }
}
