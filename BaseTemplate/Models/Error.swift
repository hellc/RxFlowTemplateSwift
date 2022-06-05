//
//  Error.swift
//  BaseTemplate
//
//  Created by @hellc on 05.06.2022.
//

import Foundation

struct CustomError: Decodable {
    let message: String?
    let code: Int?
}
