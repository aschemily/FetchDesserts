//
//  DessertDetailsViewswift.swift
//  FetchDesserts
//
//  Created by Emily Asch on 6/11/24.
//

import SwiftUI

struct DessertDetailsViewswift: View {
    let dessert: Dessert
    @ObservedObject var vm: DessertDetailsViewModel
    
    init(dessert: Dessert) {
        self.dessert = dessert
        self.vm = DessertDetailsViewModel(dessertId: dessert.idMeal)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(vm.dessertDetails, id: \.idMeal) { details in
                    VStack {
                        Text(details.strMeal)
                            .font(.largeTitle)
                        AsyncImage(url: URL(string: details.strMealThumb), content: { image in
                            image
                                .resizable()
                                .scaledToFit()
                            //.frame(maxWidth: .infinity, maxHeight: .infinity)
                        }, placeholder: {
                            EmptyView()
                        })
                        
                        Text("Instructions")
                            .font(.headline)
                        Text(details.strInstructions)
                            .font(.subheadline)
                    }
                }
                
                Text("Ingredients")
                    .font(.headline)
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(Array(vm.ingredients), id: \.self) { ingredient in
                        HStack{
                            Text("• \(ingredient)")
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Text("Measurements")
                    .font(.headline)
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(Array(vm.measurements), id: \.self) { measurement in
                        HStack{
                            Text("• \(measurement)")
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .task { await
                vm.fetchCoinDetails()
            }
        }
    }
}

#Preview {
    DessertDetailsViewswift(dessert: Dessert(idMeal: "", strMeal: "", strMealThumb: ""))
}
