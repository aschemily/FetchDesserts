//
//  DessertsViewModel.swift
//  FetchDesserts
//
//  Created by Emily Asch on 6/11/24.
//

import Foundation


class DessertsViewModel: ObservableObject {
    @Published var desserts: [Dessert] = []
    @Published var errorMessage: String?
 
    private let service = DessertDataService()
    
//    init(service: DessertDataService) {
//        self.service = service 
//    }
    
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
