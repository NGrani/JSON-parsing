//
//  JSONModel.swift
//  JSON Parsing
//
//  Created by Георгий Маркарян on 21.05.2022.
//

import UIKit

struct ResponseData: Codable {
    var squadName: String?
    var homeTown: String?
    var formed: Int?
    var secretBase: String?
    var active: Bool?
    var members: [Person]
}
struct Person : Codable {
    var name: String
    var age: Int
    var secretIdentity: String
    var wins: Int
    var powers: [String]
}

