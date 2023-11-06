//
//  Auth.swift
//  Strimus-Example
//
//  Created by Machinarium on 6.11.2023.
//

import Foundation

struct BaseResponse<T:Codable>: Codable {
    let success: Bool
    let code: Int
    let data: T
}

struct Auth: Codable {
    let uniqueId: String
    let token: String
}
