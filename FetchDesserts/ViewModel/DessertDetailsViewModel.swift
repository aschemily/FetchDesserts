//
//  DessertDetailsViewModel.swift
//  FetchDesserts
//
//  Created by Emily Asch on 6/11/24.
//

import Foundation


class DessertDetailsViewModel: ObservableObject {
    private let service = DessertDataService()
    private let dessertId: String
    @Published var errorMessage: String?
    @Published var dessertDetails: [DessertDetails] = []
    @Published var ingredients: Set<String> = Set()
    @Published var measurements: Set<String> = Set()
    
    init(dessertId: String) {
        self.dessertId = dessertId
        
    }
    
    @MainActor
    func displayDessertDetails() async {
        do {
            let details = try await service.fetchDessertDetails(id: dessertId)
            for dessert in details {
                let mirror = Mirror(reflecting: dessert)
                for child in mirror.children {
                    for i in 1...20 {
                        if child.label == "strIngredient\(i)", let ingredient = child.value as? String, !ingredient.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            let trimmedIngredient = ingredient.trimmingCharacters(in: .whitespaces)
                            ingredients.insert(trimmedIngredient)
                        }
                        if child.label == "strMeasure\(i)", let measurement = child.value as? String, !measurement.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                            let trimmedMeasurement = measurement.trimmingCharacters(in: .whitespaces)
                            measurements.insert(trimmedMeasurement)
                        }
                    }
                }
            }
            self.dessertDetails = details
        } catch {
            if let error = error as? DessertAPIError {
                self.errorMessage = error.customDescription
            } else {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
