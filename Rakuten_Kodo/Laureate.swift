//
//  Laureate.swift
//  Kobo_Test
//
//  Created by John Fowler on 1/8/21.
//

import Foundation

struct Laureate: Codable {
    let id: Int
    let category: Category
    let died, diedcity, borncity, born: String
    let surname, firstname, motivation: String
    let location: Location
    let city, borncountry, year, diedcountry: String
    let country: String
    let gender: Gender
    let name: String
}

enum Category: String, Codable {
    case chemistry = "Chemistry"
    case economics = "Economics"
    case medicine = "Medicine"
    case physics = "Physics"
}

enum Gender: String, Codable {
    case female = "female"
    case male = "male"
}

struct Location: Codable {
    let lat, lng: Double
}

typealias Welcome = [Laureate]
