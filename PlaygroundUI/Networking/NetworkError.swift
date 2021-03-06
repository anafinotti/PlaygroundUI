//
//  NetworkError.swift
//  PlaygroundUI
//
//  Created by Ana Finotti on 20/01/22.
//

import Foundation
import Alamofire

struct NetworkError: Error {
    
  let initialError: AFError
  let backendError: BackendError?
}

struct BackendError: Codable, Error {
    
    var status: String
    var message: String
}
