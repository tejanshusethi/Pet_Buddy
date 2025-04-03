//
//  addFriendView.swift
//  petBuddySwiftUI
//
//  Created by NITIN KALIRAMAN on 24/03/25.
//

import SwiftUI

struct AddFriendView: View {
    @State private var selectedSegment = 0
    @State private var searchText = ""
    
    @State private var friendsList = [
        Friend(name: "Ruby", location: "Lives near you"),
        Friend(name: "Martin", location: "Lives in your hometown"),
        Friend(name: "John", location: "Lives in Downtown"),
        Friend(name: "Sophia", location: "Lives nearby"),
        Friend(name: "Emma", location: "Lives in Uptown")
    ]
    
    @State private var friendRequests = [
        Friend(name: "Alice", location: "Sent you a request"),
        Friend(name: "Bob", location: "Sent you a request"),
        Friend(name: "Charlie", location: "Sent you a request"),
        Friend(name: "Diana", location: "Sent you a request"),
        Friend(name: "Ethan", location: "Sent you a request")
    ]
    
    @Binding var privateChats: [CommunityCellModel]
    
    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                TextField("Search friends", text: $searchText)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                // Segmented Control
                Picker("Options", selection: $selectedSegment) {
                    Text("Add new Friend").tag(0)
                    Text("Friend Request").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // List of friends or friend requests
                List {
                    if selectedSegment == 0 {
                        ForEach(friendsList) { friend in
                            FriendRow(friend: friend, actionText: "Add") {
                                sendFriendRequest(to: friend)
                            }
                        }
                    } else {
                        ForEach(friendRequests) { friend in
                            FriendRequestRow(friend: friend,
                            acceptAction: {
                                acceptFriendRequest(friend)
                            }, rejectAction: {
                                rejectFriendRequest(friend)
                            })
                        }
                    }
                }
            }
            .navigationTitle("Add Friend")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func sendFriendRequest(to friend: Friend) {
           print("Friend request sent to: \(friend.name)")
       }

       private func acceptFriendRequest(_ friend: Friend) {
           print("✅ Accepting friend request: \(friend.name)")
           let newPrivateChat = CommunityCellModel(
               communityName: friend.name,
               communityImageName: "person.circle",
               description: "Private chat with \(friend.name)",
               members: [friend.name],
               chatMessages: []
           )

           privateChats.append(newPrivateChat) // ✅ Adds the friend as a private chat
           friendRequests.removeAll { $0.id == friend.id }
       }

       private func rejectFriendRequest(_ friend: Friend) {
           print("❌ Rejecting friend request: \(friend.name)")  // Debug Log

           friendRequests.removeAll { $0.id == friend.id }
           
       }
}

struct FriendRow: View {
    var friend: Friend
    var actionText: String
    var action: () -> Void
    
    
    var body: some View {
        HStack {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading) {
                Text(friend.name).font(.headline)
                Text(friend.location).font(.subheadline).foregroundColor(.gray)
            }
            Spacer()
            Button(action: action) {
                            Text("Add")
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                        
                        
        }
    }
}

struct FriendRequestRow: View {
    var friend: Friend
    var acceptAction: () -> Void
    var rejectAction: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading) {
                Text(friend.name).font(.headline)
                Text("Sent you a request").font(.subheadline).foregroundColor(.gray)
            }
            Spacer()
            
            Button(action: {acceptAction()}) {
                Text("Accept")
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            
            Button(action: {rejectAction()}) {
                Text("Reject")
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.red)
                    .cornerRadius(8)
            }
        }
    }
}


