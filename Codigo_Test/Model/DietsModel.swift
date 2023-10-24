//
//  DietsModel.swift
//  Codigo_Test
//
//  Created by Kyaw Ye Htun on 24/10/2023.
//

import Foundation
struct DietsData: Decodable {
   let data : [DietsModel]

   enum CodingKeys : String, CodingKey { case data = "data" }
}

struct DietsModel: Decodable {
    var id: Int
    var name: String
    var tool_tip : String
}
