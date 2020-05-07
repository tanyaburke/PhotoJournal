//
//  NewEntryViewController.swift
//  PhotoJournalApp
//
//  Created by Tanya Burke on 2/18/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit

class NewEntryViewController: UIViewController {

    @IBOutlet weak var descriptionEntry: UITextView!
    
    @IBOutlet weak var selectedImage: UIImageView!
    private var imagePickerController = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func photoButtonPressed(_ sender: UIButton) {
        
         let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                   let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] alertAction in
                     self?.showImageController(isCameraSelected: true)
                   }
        
                   let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { [weak self] alertAction in
                     self?.showImageController(isCameraSelected: false)
                   }
                   let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
                   // check if camera is available, if camera is not available and you attempt to show
                   // the camera the app will crash
                   if UIImagePickerController.isSourceTypeAvailable(.camera) {
                     alertController.addAction(cameraAction)
                   }
        
                   alertController.addAction(photoLibraryAction)
                   alertController.addAction(cancelAction)
                   present(alertController, animated: true)
        
            }
        
            private func showImageController(isCameraSelected: Bool) {
               // source type default will be .photoLibrary
               imagePickerController.sourceType = .photoLibrary
        
               if isCameraSelected {
                 imagePickerController.sourceType = .camera
               }
               present(imagePickerController, animated: true)
             }
    }
    
