//
//  CollectionViewCell.swift
//  PhotoJournalApp
//
//  Created by Tanya Burke on 2/19/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    @IBOutlet weak var photoViem: UIImageView!
    
    @IBOutlet weak var descriptionText: UILabel!

   
    override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = 20.0
        backgroundColor = .darkGray
    //cell.delegate = self
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
