//
//  MealService.swift
//  Desserts-Gallore-y
//
//  Created by Chellsea Carmel on 7/3/24.
//

import Foundation

// A class handling all the meal related API calls.
class MealService {
    // Initializer
    static let shared = MealService()
    
    /// This function performs a network request to fetch all the desserts on themealdb.com
    ///  - Parameters: None
    ///  - Returns: A list of meal objects each containing basic information for a particular dessert
    func fetchDesserts() async throws -> [Meal] {
        let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=dessert")!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let mealListResponse = try JSONDecoder().decode(MealListResponse.self, from: data)
        
        var filteredMeals : [Meal] = []
        
        for meal in mealListResponse.meals{
            if let strMeal = meal.strMeal, !strMeal.isEmpty,
               let strMealThumb = meal.strMealThumb, !strMealThumb.isEmpty {
                            filteredMeals.append(meal)
            }
        }
        return filteredMeals
    }
    
    /// This function performs a network request to fetch detailed information of a particulae dessert from themealdb.com
    ///  - Parameter id: A string contiang the id of the dessert.
    ///  - Returns: A meal detail object with detailed information about a particular dessert.
    func fetchDessertDetail(by id: String) async throws -> MealDetail {
        let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)")!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let mealDetailResponse = try JSONDecoder().decode(MealDetailResponse.self, from: data)
        guard let mealDetail = mealDetailResponse.meals.first else {
            throw NSError(domain: "mealDetailError", code: 404, userInfo: nil)
        }
        return mealDetail
    }
}

