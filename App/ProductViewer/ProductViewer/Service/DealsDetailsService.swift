//
//  DealsDetailsService.swift
//  ProductViewer
//
//  Created by Kalyani Chinchane on 23/08/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
protocol DealsDetailsServiceEntity: ServiceEntity {
    func getDealDetails(for id: Int,
                        completion: @escaping (_ resp: Product?,
                                               _ message: String?) -> Void)
}

class DealsDetailsService: Service, DealsDetailsServiceEntity {
    func getDealDetails(for id: Int,
                        completion: @escaping (_ resp: Product?,
                                               _ message: String?) -> Void)  {
        defaultSession = URLSession.init(configuration: .default)
        dataTask?.cancel()
        let baseURL = String("https://api.target.com/mobile_case_study_deals/v1/deals/")
        let urlComp: String = baseURL + "\(id)"
        guard let url = URL(string: urlComp) else {
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
                guard let products = try? decoder.decode(Product.self,
                                                         from: dataObj) else {
                    return
                }
                
                completion(products, self?.errorMessage)
            }
        }
        dataTask?.resume()
    }
}
