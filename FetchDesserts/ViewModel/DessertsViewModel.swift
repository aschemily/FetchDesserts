//
//  DessertsViewModel.swift
//  FetchDesserts
//
//  Created by Emily Asch on 6/11/24.
//

import Foundation

@MainActor
class DessertsViewModel: ObservableObject {
    @Published var desserts: [Dessert] = []
 
    private let service = DessertDataService()
    
    init() {
        Task {
           try await displayDesserts()
        }
    }
    
    
    func displayDesserts() async throws {
        desserts = try await service.fetchDesserts().sorted(by: { $0.strMeal < $1.strMeal })
    }
    
    
}
