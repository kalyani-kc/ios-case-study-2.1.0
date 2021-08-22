//
//  Service.swift
//  ProductViewer
//
//  Created by Kalyani Chinchane on 21/08/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation

protocol ServiceEntity {
    //
}

class Service: ServiceEntity {
    var delegate: URLSessionDelegate?
    var defaultSession: URLSession?
    var dataTask: URLSessionDataTask?
    var errorMessage: String?
    
}
