//
//  ProductResponse.swift
//  ProductViewer
//
//  Created by Kalyani Chinchane on 21/08/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation

struct Price: Decodable {
    var amountInCents: Double
    var currency: String
    var displayPrice: String
    
    private enum CodingKeys: String, CodingKey {
        typealias RawValue = String
        
        case amountInCents = "amount_in_cents"
        case currency = "currency_symbol"
        case displayPrice = "display_string"
    }
    init(from decoder: Decoder) throws {
        let price = try decoder.container(keyedBy: CodingKeys.self)
        amountInCents = try price.decode(Double.self, forKey: .amountInCents)
        currency = try price.decode(String.self, forKey: .currency)
        displayPrice = try price.decode(String.self, forKey: .displayPrice)
    }
}
struct Product: Decodable {
    var id: Int
    var title: String
    var aisle: String
    var imageURL: String
    var regularPrice: Price
    var description: String?
    
    private enum CodingKeys: String, CodingKey {
        typealias RawValue = String
        case id
        case title
        case aisle
        case imageURL = "image_url"
        case regularPrice = "regular_price"
        case description
    }
    init(from decoder: Decoder) throws {
        let product = try decoder.container(keyedBy: CodingKeys.self)
        id = try product.decode(Int.self, forKey: .id)
        title = try product.decode(String.self, forKey: .title)
        aisle = try product.decode(String.self, forKey: .aisle)
        imageURL = try product.decode(String.self, forKey: .imageURL)
        regularPrice = try product.decode(Price.self, forKey: .regularPrice)
        description = try product.decode(String.self, forKey: .description)
    }
}

struct Deals: Decodable {
    var products:[Product]
    
    private enum CodingKeys: String, CodingKey {
        case products = "products"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        products = try values.decode([Product].self, forKey: .products)
    }
}
