//
//  DessertsViewModel.swift
//  FetchDesserts
//
//  Created by Emily Asch on 6/11/24.
//

import Foundation


class DessertsViewModel: ObservableObject {
    private let service = DessertDataService()
    @Published var desserts: [Dessert] = []
    @Published var errorMessage: String?
    
    @MainActor
    func displayDesserts() async {
        do {
            self.desserts = try await service.fetchDesserts().sorted(by: { $0.strMeal < $1.strMeal })
        } catch {
            if let error = error as? DessertAPIError {
                self.errorMessage = error.customDescription
            } else {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
