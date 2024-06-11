//
//  Dessert.swift
//  FetchDesserts
//
//  Created by Emily Asch on 6/11/24.
//

import Foundation

struct Meals: Decodable {
    let meals: [Dessert]
}

struct Dessert: Decodable, Equatable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String 
   
}
