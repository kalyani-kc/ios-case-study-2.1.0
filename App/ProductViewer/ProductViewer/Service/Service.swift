//
//  Service.swift
//  ProductViewer
//
//  Created by Kalyani Chinchane on 21/08/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation

protocol ServiceEntity {
    func getListOfDeals(completion: @escaping (_ resp: Deals?,
                                               _ message: String?) -> Void)
}

class Service: ServiceEntity {
    var delegate: URLSessionDelegate?
    var defaultSession: URLSession?
    var dataTask: URLSessionDataTask?
    var errorMessage: String?
    
    func getListOfDeals(completion: @escaping (_ resp: Deals?,
                                               _ message: String?) -> Void) {
        defaultSession = URLSession.init(configuration: .default)
        dataTask?.cancel()
        
        guard let url = URL.init(string: "https://api.target.com/mobile_case_study_deals/v1/deals") else {
            return
        }
        dataTask = defaultSession?.dataTask(with: url) { [weak self] data,
                                                                     response,
                                                                     error in
            defer {
                self?.dataTask = nil
            }
            
            if let error = error {
                self?.errorMessage = error.localizedDescription
            } else if let dataObj = data,
                      let response1 = response as? HTTPURLResponse,
                      response1.statusCode == 200 {

                let decoder = JSONDecoder()
                guard let products = try? decoder.decode(Deals.self,
                                                         from: dataObj) else {
                    return
                }
                
                    completion(products, self?.errorMessage)
            }
        }
        dataTask?.resume()
    }
}
