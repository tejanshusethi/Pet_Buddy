//
//  SwiftUIView.swift
//  petBuddySwiftUI
//
//  Created by NITIN KALIRAMAN on 23/03/25.
//
import SwiftUI

struct CommunityChatsView: View {
    @State private var showAlert = false
    @State var community: CommunityCellModel
    @Binding var communities: [CommunityCellModel]
    
    
    
//    let communityName: String
//    let communityImage: String
//    @State private var messages: [Message] = [
//        Message(text: "Hi there! How can I help you today?", isUser: false),
//        Message(text: "I'm looking for some advice on car maintenance.", isUser: true),
//        Message(text: "Sure! Regular servicing and checking your oil levels are key. Anything specific you're concerned about?", isUser: false),
//        Message(text: "Yes, I think my brakes are squeaking. What should I do?", isUser: true),
//        Message(text: "Squeaky brakes might indicate worn brake pads. It's best to get them inspected by a mechanic.", isUser: false)
//    ]
    @State private var newMessage: String = ""
    

    
    
    var body: some View {
        VStack {
            // Header
            NavigationLink(destination: CommunityDetailsView(community: community,communities: $communities)) {
                            VStack {
                                Image(community.communityImageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 150)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    

                                Text(community.communityName)
                                    .font(.headline)
                                    .padding(.top, 5)
                            }
                            .padding(.top, 10)
                        }


            // Chat Messages
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(community.chatMessages.indices, id: \.self) { index in
                                            let message = community.chatMessages[index]
                                            HStack {
                                                if message.username == "You" { // User's message (Blue)
                                                    Spacer()
                                                    Text(message.message)
                                                        .padding()
                                                        .background(Color.blue)
                                                        .foregroundColor(.white)
                                                        .cornerRadius(10)
                                                } else { // Other messages (Gray)
                                                    VStack(alignment: .leading) {
                                                        Text(message.username)
                                                            .font(.caption)
                                                            .foregroundColor(.gray)
                                                        Text(message.message)
                                                            .padding()
                                                            .background(Color.gray.opacity(0.3))
                                                            .cornerRadius(10)
                                                    }
                                                    Spacer()
                                                }
                                            }
                                        }
                }
                .padding()
            }

            // Text Input Field
            HStack {
                TextField("Type a message...", text: $newMessage)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                
                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
            }
            .padding()
        }
        .navigationBarTitle("Community", displayMode: .inline)
        .toolbar(.hidden, for: .tabBar)
        .navigationBarItems(trailing:
                    Button("Clear All Chats") {
                        showAlert = true
                    }
                )
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Clear Chats"),
                        message: Text("Are you sure you want to delete all messages?"),
                        primaryButton: .destructive(Text("OK")) {
                            community.chatMessages.removeAll() // Clears the chat messages
                        },
                        secondaryButton: .cancel()
                    )
                }
    }

    private func sendMessage() {
        let trimmedMessage = newMessage.trimmingCharacters(in: .whitespacesAndNewlines)
                guard !trimmedMessage.isEmpty else { return }
        
        community.chatMessages.append(ChatMessage(username: "You", message: trimmedMessage))
        newMessage = ""
    }
}

// Message Model
struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
}

// Example Community List
