//
//  ChatScreen.swift
//  SwiftChat
//
//  Created by Dheeraj on 10/27/22.
//

import SwiftUI

struct ChatScreen: View {
    @EnvironmentObject private var userInfo: UserInfo
    @State private var message = ""
    @StateObject private var model = ChatScreenModel() // <- this here
    private func onAppear() {
        model.connect(username: userInfo.username, userID: userInfo.userID)
    }
    private func onDisappear() {
        model.disconnect()
    }
    private func onCommit() {
        if !message.isEmpty {
            model.send(text: message)
            message = ""
        }
    }
    private func scrollToLastMessage(proxy: ScrollViewProxy) {
        if let lastMessage = model.messages.last { // 4
            withAnimation(.easeOut(duration: 0.4)) {
                proxy.scrollTo(lastMessage.id, anchor: .bottom) // 5
            }
        }
    }
    var body: some View {
        VStack {
            // Chat history.
            ScrollView {
                ScrollViewReader { proxy in
                    LazyVStack(spacing: 8) {
                        ForEach(model.messages) { message in
                            // This one right here 👇, officer.
                            ChatMessageRow(message: message, isUser: message.userID == userInfo.userID)
                                .id(message.id)
                        }
                    }
                    // etc.
                }
            }

            // Message field.
            HStack {
                TextField("Message", text: $message, onEditingChanged: { _ in }, onCommit: onCommit) // 2
                    .padding(10)
                    .background(Color.secondary.opacity(0.2))
                    .cornerRadius(5)
                
                Button(action: onCommit) { // 3
                    Image(systemName: "arrowshape.turn.up.right")
                        .font(.system(size: 20))
                }
                .padding()
                .disabled(message.isEmpty) // 4
            }
            .padding()
        }
        .onAppear(perform: onAppear)
        .onDisappear(perform: onDisappear)
    }
}
struct ChatMessageRow: View {
    static private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()
    
    let message: ReceivingChatMessage
    let isUser: Bool
    
    var body: some View {
        HStack {
            if isUser {
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(message.user)
                        .fontWeight(.bold)
                        .font(.system(size: 12))
                    
                    Text(Self.dateFormatter.string(from: message.date))
                        .font(.system(size: 10))
                        .opacity(0.7)
                }
                
                Text(message.message)
            }
            .foregroundColor(isUser ? .white : .black)
            .padding(10)
            .background(isUser ? Color.blue : Color(white: 0.95))
            .cornerRadius(5)
            
            if !isUser {
                Spacer()
            }
        }
    }
}
