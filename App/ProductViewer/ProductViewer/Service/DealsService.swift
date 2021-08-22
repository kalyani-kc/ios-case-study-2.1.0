//
//  DealsService.swift
//  ProductViewer
//
//  Created by Kalyani Chinchane on 23/08/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation

protocol DealsServiceEntity: ServiceEntity {
    func getListOfDeals(completion: @escaping (_ resp: Deals?,
                                               _ message: String?) -> Void)
}

class DealsService: Service, DealsServiceEntity {
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
