//
//  MealModels.swift
//  Desserts-Gallore-y
//
//  Created by Chellsea Carmel on 7/3/24.
//

import Foundation

/// A struct containing basic meal information.
struct Meal: Codable, Identifiable {
    let idMeal: String
    let strMeal: String?
    let strMealThumb: String?
    
    var id: String {
        return idMeal
    }
}

/// A struct to handle a list of Meals. Usually used when getting meals from the API.
struct MealListResponse: Codable {
    let meals: [Meal]
}

/// A struct to handle a list of MealDetail objects. Usually used when getting meal details from the API.
struct MealDetailResponse: Codable {
    let meals: [MealDetail]
}

/// A struct containing detailed information about a particular meal.
struct MealDetail: Codable {
    let idMeal: String
    let strMeal: String
    let strInstructions: String
    let strMealThumb: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
    
    var ingredients: [(String, String)] {
       
        var ingredientsArray: [(String, String)] = []

            let ingredientArrays = [
                [strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5],
                [strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10],
                [strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15],
                [strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20]
            ]
            
            let measureArrays = [
                [strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5],
                [strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10],
                [strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15],
                [strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20]
            ]

            for i in 0..<ingredientArrays.count {
                for j in 0..<ingredientArrays[i].count {
                    let ingredient = ingredientArrays[i][j] ?? ""
                    let measure = measureArrays[i][j] ?? ""
                    if !ingredient.isEmpty {
                        ingredientsArray.append((ingredient, measure))
                    }
                }
            }
            return ingredientsArray
    }
}

