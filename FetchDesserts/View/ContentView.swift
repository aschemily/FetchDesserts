//
//  ContentView.swift
//  FetchDesserts
//
//  Created by Emily Asch on 6/11/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = DessertsViewModel()
    var body: some View {
        NavigationStack {
            Text("Desserts")
                .font(.largeTitle)
            List {
                ForEach(vm.desserts, id: \.idMeal) { dessert in
                    NavigationLink(value: dessert, label: {
                        Text("\(dessert.strMeal)")
                            .padding()
                            .font(.headline)
                    })
                    
                }
            }
            .navigationDestination(for: Dessert.self, destination: { dessert in
                DessertDetailsViewswift(dessert: dessert)
            })
        }
        .task { await
            vm.displayDesserts()
        }
        .overlay {
            if let error = vm.errorMessage {
                Text(error)
            }
        }
    }
}

#Preview {
    ContentView(vm: DessertsViewModel())
}
