//
//  NewEntryViewController.swift
//  PhotoJournalApp
//
//  Created by Tanya Burke on 2/18/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit
import AVFoundation

class NewEntryViewController: UIViewController {
    
    @IBOutlet weak var descriptionEntry: UITextView!
    
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var photobutton: UIBarButtonItem!
    
    private var imagePickerController = UIImagePickerController()
    private let dataPersistence = PersistenceHelper(filename: "images.plist")
    
    var imageObject: ImageObject!
    
    private var imageObjects = [ImageObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        // Do any additional setup after loading the view.
    }
    
    private func appendNewPhotoToCollection() {
        guard let image = selectedImage.image else {
            print("image is nil")
            return
        }
        
        print("original image size is \(image.size)")
        
        // the size for resizing of the image
        let size = UIScreen.main.bounds.size
        
        // we will maintain the aspect ratio of the image
        let rect = AVMakeRect(aspectRatio: image.size, insideRect: CGRect(origin: CGPoint.zero, size: size))
        
        // resize image
        let resizeImage = image.resizeImage(to: rect.size.width, height: rect.size.height)
        
        print("resized image size is \(resizeImage.size)")
        
        // jpegData(compressionQuality: 1.0) converts UIImage to Data
        guard let resizedImageData = resizeImage.jpegData(compressionQuality: 1.0) else {
            return
            
        }    // create an ImageObject using the image selected
        let imageObject = ImageObject(imageData: resizedImageData, date: Date(), description: descriptionEntry.text )
        
        do {
            try dataPersistence.create(item: imageObject) // end of array in persistence store
        } catch {
            print("saving error: \(error)")
        }
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        appendNewPhotoToCollection()
        
        
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

extension NewEntryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // we need to access the UIImagePickerController.InfoKey.orginalImage key to get the
        // UIImage that was selected
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            print("image selected not found")
            return
        }
        
        selectedImage.image = image
        photobutton.isEnabled = false
        
        
        dismiss(animated: true)
    }
}

