//
//  FileManager+Extensions.swift
//  PhotoJournalApp
//
//  Created by Tanya Burke on 5/1/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import Foundation

extension FileManager {

  static func getDocumentsDirectory() -> URL  {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
  }
  
 
  static func pathToDocumentsDirectory(with filename: String) -> URL {
    return getDocumentsDirectory().appendingPathComponent(filename)
  }
}
