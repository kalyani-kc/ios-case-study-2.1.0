//
//  APIResponse.swift
//  ProductViewer
//
//  Created by Kalyani Chinchane on 21/08/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
protocol InitializableWithData {
    init(data: Data?) throws
}

struct ApiError: Error {
    let data: Data?
    let httpUrlResponse: HTTPURLResponse
}

struct ApiParseError: Error {
    static let code = 999
    
    let error: Error
    let httpUrlResponse: HTTPURLResponse
    let data: Data?
    
    var localizedDescription: String {
        return error.localizedDescription
    }
}
struct ApiResponse<T: InitializableWithData> {
    let entity: T
    let httpUrlResponse: HTTPURLResponse
    let data: Data?
    
    init(data: Data?, httpUrlResponse: HTTPURLResponse) throws {
        do {
            self.entity = try T(data: data)
            self.httpUrlResponse = httpUrlResponse
            self.data = data
        } catch {
            throw ApiParseError(error: error, httpUrlResponse: httpUrlResponse, data: data)
        }
    }
}
