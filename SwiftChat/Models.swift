//
//  Models.swift
//  SwiftChat
//
//  Created by Dheeraj on 10/27/22.
//

import Foundation

struct SubmittedChatMessage: Encodable{
    let message: String
    let user: String // <- We
    let userID: UUID // <- are
}

struct ReceivingChatMessage: Decodable, Identifiable {
    let date = Date()
    let id = UUID()
    let message: String
    let user: String // <- new
    let userID: UUID // <- here
}
