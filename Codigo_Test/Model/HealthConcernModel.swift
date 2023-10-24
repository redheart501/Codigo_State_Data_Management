//
//  HealthConcernModel.swift
//  Codigo_Test
//
//  Created by Kyaw Ye Htun on 23/10/2023.
//

import Foundation

struct HealthConcernData: Decodable {
   let data : [HealthConcernModel]

   enum CodingKeys : String, CodingKey { case data = "data" }
}

struct HealthConcernModel: Decodable {
    var id: Int
    var name: String
}
