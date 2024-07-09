//
//  Desserts_Gallore_yTests.swift
//  Desserts-Gallore-yTests
//
//  Created by Chellsea Carmel on 7/3/24.
//

import XCTest
@testable import Desserts_Gallore_y


final class Desserts_Gallore_yTests: XCTestCase {
    
    /// Function to check if the result from fetchDesserts is not empty.
    func test_fetch_desserts_result() async throws {
        let desserts = try await MealService.shared.fetchDesserts()
        
        XCTAssertFalse(desserts.isEmpty,"Desserts array should not be empty")
    }
    
    /// Fucntion to check if the result from fetchDessertDetail for a vaild id is not Empty.
    func test_fetch_desserts_detailed_valid() async throws {
        let dessertDetail = try await MealService.shared.fetchDessertDetail(by: "52853")
        
        XCTAssertNotNil(dessertDetail,"DessertDetails should not be empty")
    }
    
    /// Fucntion to check if the result from fetchDessertDetail for an invaild id throws an Error.
    func test_fetch_desserts_detailed_invalid() async throws {

        do {
            _ = try await MealService.shared.fetchDessertDetail(by: "0")
            XCTFail("Expected fetchDesertDetail to throw an error for invalid id")
        }catch{
            XCTAssert(true, "Error was thrown as expected");
        }
        
    }
    
    /// Fucntion to check if the result from fetchDessertDetail for an empty id throws an Error.
    func test_fetch_desserts_detailed_empty() async throws {

        do {
            _ = try await MealService.shared.fetchDessertDetail(by: "")
            XCTFail("Expected fetchDesertDetail to throw an error for an empty id")
        }catch{
            XCTAssert(true, "Error was thrown as expected");
        }
        
    }
}
