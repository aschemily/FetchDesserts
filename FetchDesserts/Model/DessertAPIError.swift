//
//  DessertAPIError.swift
//  FetchDesserts
//
//  Created by Emily Asch on 6/11/24.
//

import Foundation

enum DessertAPIError: Error {
    case invalidData
    case requestFailed(description: String)
    case unknownError(error: Error)
    
    var customDescription: String {
        switch self {
        case .invalidData:
            return "Invalid data"
        case .requestFailed(let description):
            return "request failed \(description)"
        case .unknownError(let error):
            return "unknown error occurred \(error.localizedDescription)"
        }
    }
}
