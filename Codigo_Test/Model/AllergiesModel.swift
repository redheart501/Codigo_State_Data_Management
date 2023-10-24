//
//  AllergiesModel.swift
//  Codigo_Test
//
//  Created by Kyaw Ye Htun on 24/10/2023.
//

import Foundation

struct AllergiesData: Decodable {
   let data : [AllergiesModel]

   enum CodingKeys : String, CodingKey { case data = "data" }
}

struct AllergiesModel: Decodable {
    var id: Int
    var name: String
}


struct simpleOutputData : Decodable {
    let health_concerns: [HealthConcernModel]
    let diets: [DietsModel]
    let allergies: [AllergiesModel]
    var is_daily_exposure: Bool!
    var is_somke: Bool!
    var alchol: String = ""
    
    enum CodingKeys: String, CodingKey {
            case health_concerns
            case diets
            case allergies
        case is_daily_exposure
        case is_somke
        case alchol
        }
}

struct lastQuzModel: Decodable {
    var is_daily_exposure: Bool!
    var is_somke: Bool!
    var alchol: String = ""
    
    enum CodingKeys: String, CodingKey {
        
        case is_daily_exposure
        case is_somke
        case alchol
        }
}
