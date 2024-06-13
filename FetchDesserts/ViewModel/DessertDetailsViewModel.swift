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
        print("inside display dessert details")
        do {
            let details = try await service.fetchDessertDetails(id: dessertId)
            print("inside DO display dessert details")
            for dessert in details {
                let mirror = Mirror(reflecting: dessert)
                for child in mirror.children {
                    for i in 1...20 {
                        if child.label == "strIngredient\(i)", let ingredient = child.value as? String, !ingredient.isEmpty {
                            ingredients.insert(ingredient)
                        }
                        if child.label == "strMeasure\(i)", let measurement = child.value as? String, !measurement.isEmpty {
                            measurements.insert(measurement)
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
