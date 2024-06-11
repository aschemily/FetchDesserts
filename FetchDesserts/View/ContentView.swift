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
                    Text("\(dessert.strMeal)")
                        .padding()
                        .font(.headline)
                    
                    AsyncImage(url: URL(string: dessert.strMealThumb))
                }
            }
        }
    }
}

#Preview {
    ContentView(vm: DessertsViewModel())
}
