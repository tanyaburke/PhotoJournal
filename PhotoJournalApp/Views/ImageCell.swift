//
//  CollectionViewCell.swift
//  PhotoJournalApp
//
//  Created by Tanya Burke on 2/19/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit

protocol ImageCellDelegate: AnyObject {
  func didLongPress(_ imageCell: ImageCell)
}
class ImageCell: UICollectionViewCell {
    @IBOutlet weak var photoViem: UIImageView!
    
    @IBOutlet weak var descriptionText: UILabel!

     weak var delegate: ImageCellDelegate?
    
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
      let gesture = UILongPressGestureRecognizer()
      gesture.addTarget(self, action: #selector(longPressAction(gesture:)))
      return gesture
    }()
   
    override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = 20.0
        backgroundColor = .darkGray
        
        addGestureRecognizer(longPressGesture)
    //cell.delegate = self
}
    
    @objc
     private func longPressAction(gesture: UILongPressGestureRecognizer) {
       if gesture.state == .began { // if gesture is active
         gesture.state = .cancelled
         return
       }
       
       // step 3: creating custom delegation - explicity use
       // delegate object to notify of any updates e.g
       // notifying the ImagesViewController when the user long presses on the cell
       delegate?.didLongPress(self)
       // cell.delegate = self
       // imagesViewController -> didLongPress(:)
     }
     
    public func configureCell(imageObject: ImageObject) {
       // converting Data to UIImage
        guard let image = UIImage(data: imageObject.imageData) else {
         return
       }
        photoViem.image = image
        descriptionText.text = imageObject.description
        
        
     }
}
