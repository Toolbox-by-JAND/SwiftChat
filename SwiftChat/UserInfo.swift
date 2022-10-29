//
//  UserInfo.swift
//  SwiftChat
//
//  Created by Dheeraj on 10/27/22.
//

import Combine
import Foundation

class UserInfo: ObservableObject {
    let userID = UUID()
    @Published var username = ""
}
