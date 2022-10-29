//
//  ContentView.swift
//  SwiftChat
//
//  Created by Dheeraj on 10/27/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var userInfo = UserInfo() // 1
    
    var body: some View {
        NavigationView {
            SettingsScreen()
        }
        .environmentObject(userInfo) // 2
        .navigationViewStyle(StackNavigationViewStyle()) // 3
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
