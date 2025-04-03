//
//  addMemberToCommunity.swift
//  petBuddySwiftUI
//
//  Created by NITIN KALIRAMAN on 24/03/25.
//

import SwiftUI

struct AddMemberToCommunity: View {
    @State private var searchText = ""
    @State private var friendsList = [
        Friend(name: "Ruby", location: "Lives near you"),
        Friend(name: "Martin", location: "Lives in your hometown"),
        Friend(name: "John", location: "Lives in Downtown"),
        Friend(name: "Sophia", location: "Lives nearby"),
        Friend(name: "Emma", location: "Lives in Uptown")
    ]
    @Environment(\.presentationMode) var presentationMode
    @Binding var communityMembers: [Friend]
    @State private var addedFriends: Set<UUID> = [] // Track added members

    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search friends", text: $searchText)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                List {
                    ForEach(friendsList.filter { friend in
                                            searchText.isEmpty || friend.name.localizedCaseInsensitiveContains(searchText)
                                        }) { friend in
                                            FriendRow(friend: friend, actionText: addedFriends.contains(friend.id) ? "Added" : "Add") {
                                                addToCommunity(friend)
                                            }
                                            .disabled(addedFriends.contains(friend.id)) // Disable button after adding
                                        }
                }
            }
            .navigationTitle("Add Friend")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func addToCommunity(_ friend: Friend) {
        guard !communityMembers.contains(where: { $0.id == friend.id }) else { return }
        communityMembers.append(friend)
        friendsList.removeAll { $0.id == friend.id }
        

        
    }
}

//struct FriendRow: View {
//    var friend: Friend
//    var action: () -> Void
//    
//    var body: some View {
//        HStack {
//            Image(systemName: "person.circle")
//                .resizable()
//                .frame(width: 40, height: 40)
//            
//            VStack(alignment: .leading) {
//                Text(friend.name).font(.headline)
//                Text(friend.location).font(.subheadline).foregroundColor(.gray)
//            }
//            Spacer()
//            
//            Button(action: action) {
//                Text("Add")
//                    .foregroundColor(.white)
//                    .padding(.horizontal, 16)
//                    .padding(.vertical, 8)
//                    .background(Color.blue)
//                    .cornerRadius(8)
//            }
//        }
//    }
//}


