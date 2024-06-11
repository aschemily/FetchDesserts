//
//  DessertDataService.swift
//  FetchDesserts
//
//  Created by Emily Asch on 6/11/24.
//

import Foundation


class DessertDataService {
    private let urlString = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    
    func fetchDesserts() async throws -> [Dessert] {
        guard let url = URL(string: urlString) else { throw DessertAPIError.requestFailed(description: "invalid endpoint") }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let mealResponse = try JSONDecoder().decode(Meals.self, from: data)
            return mealResponse.meals
        } catch {
            throw error as? DessertAPIError ?? .unknownError(error: error)
        }
    }
}
