//
//  ImageObject.swift
//  PhotoJournalApp
//
//  Created by Tanya Burke on 5/1/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import Foundation

struct ImageObject: Codable {
  let imageData: Data
  let date: Date
  let description: String?
    let identifier = UUID().uuidString
}
