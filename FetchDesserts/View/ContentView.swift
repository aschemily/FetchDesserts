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
            List {
                ForEach(vm.desserts, id: \.idMeal) { dessert in
                    NavigationLink(value: dessert, label: {
                        Text("\(dessert.strMeal)")
                            .padding()
                            .font(.headline)
                        //AsyncImage(url: URL(string: dessert.strMealThumb))
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
