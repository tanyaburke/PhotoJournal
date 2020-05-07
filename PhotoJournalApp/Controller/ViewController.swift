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
    
//    var images = [UIImage]() {
//        didSet {
//            imageCollectionView.reloadData()
//        }
//    }
    
    private var imageObjects = [ImageObject]()
    var imageObject: ImageObject!
    private let imagePickerController = UIImagePickerController()
    
    private let dataPersistence = PersistenceHelper(filename: "images.plist")
    
    private var selectedImage: UIImage? {
      didSet {
       

      }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        
        
           
           loadImageObjects()
    }
    
    private func loadImageObjects() {
      do {
        imageObjects = try dataPersistence.loadItems()
        
      } catch {
        print("loading objects error: \(error)")
      }
    }
    
    
    @IBAction func unwindFromNew(segue: UIStoryboardSegue){
//        we need access to the source destination view controller
        
        guard  let newEntryViewController = segue.source as? NewEntryViewController else{
            return
        }
        loadImageObjects()
        imageObject = newEntryViewController.imageObject
//        afterevent is set here, didSet{...} on the event property gets called
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
    return imageObjects.count
        //return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCell else {
            fatalError("Was expecting an CollectionViewCell, but found a different type")
        }
//        let image = images[indexPath.row]
          let imageObject = imageObjects[indexPath.row]
        cell.configureCell(imageObject: imageObject)
        
        cell.delegate = self
        return cell
    }
}




extension ViewController: ImageCellDelegate {
  func didLongPress(_ imageCell: ImageCell) {
    
    guard let indexPath = imageCollectionView.indexPath(for: imageCell) else {
      return
    }
    
    // present an action sheet
    
    // actions: delete, cancel
    let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] alertAction in
      self?.deleteImageObject(indexPath: indexPath)
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    alertController.addAction(deleteAction)
    alertController.addAction(cancelAction)
    present(alertController, animated: true)
  }
  
  private func deleteImageObject(indexPath: IndexPath) {
    dataPersistence.sync(items: imageObjects)
    do {
      imageObjects = try dataPersistence.loadItems()
    } catch {
      print("loading error: \(error)")
    }
    
    // delete imageObject from imageObjects
    imageObjects.remove(at: indexPath.row)
    
    // delete cell from collection view
    imageCollectionView.deleteItems(at: [indexPath])
    
    do {
      // delete image object from documents directory
      try dataPersistence.delete(item: indexPath.row)
    } catch {
      print("error deleting item: \(error)")
    }
  }
}

extension UIImage {
  func resizeImage(to width: CGFloat, height: CGFloat) -> UIImage {
    let size = CGSize(width: width, height: height)
    let renderer = UIGraphicsImageRenderer(size: size)
    return renderer.image { (context) in
      self.draw(in: CGRect(origin: .zero, size: size))
    }
  }
}

