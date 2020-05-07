//
//  FileManager+Extensions.swift
//  PhotoJournalApp
//
//  Created by Tanya Burke on 5/1/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import Foundation


public enum Directory {
  case documentsDirectory
  case cachesDirectory
}

extension FileManager {

  static func getDocumentsDirectory() -> URL  {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
  }
  
 
  static func pathToDocumentsDirectory(with filename: String) -> URL {
    return getDocumentsDirectory().appendingPathComponent(filename)
  }
    public static func getCachesDirectory() -> URL {
      return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    }
    
    public static func getPath(with filename: String, for directory: Directory) -> URL {
      switch directory {
      case .cachesDirectory:
        return getCachesDirectory().appendingPathComponent(filename)
      case .documentsDirectory:
        return getDocumentsDirectory().appendingPathComponent(filename)
      }
    }
}
