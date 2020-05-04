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
    
    @IBAction func cameraButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func photoButtonPressed(_ sender: UIButton) {
    }
    /*
    //DEtail controller
     make the protocol delegate/ create protocol and function in here
     
     //Enum for photo state, make it chanfge if it has a photo loadedd or not
     
     it has two cases that detects newphoto/existing photo
     
   change state of view controller depending on whether or not a photo has been passed to it
     this handles whether they add or
    */
//make an instance of
}
