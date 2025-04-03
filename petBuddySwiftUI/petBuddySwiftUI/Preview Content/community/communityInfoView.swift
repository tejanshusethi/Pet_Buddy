////
////  communityInfoView.swift
////  petBuddySwiftUI
////
////  Created by NITIN KALIRAMAN on 23/03/25.
////
//
//import SwiftUI
//
//struct CommunityDetailsView: View {
//    var community: CommunityCellModel
//    @Environment(\.presentationMode) var presentationMode
//    
//    var body: some View {
//        VStack {
//            // Community Image
//            Image(community.communityImageName)
//                .resizable()
//                .scaledToFit()
//                .frame(width: 150, height: 150)
////                .clipShape(RoundedRectangle(cornerRadius: 10))
//                
//            
//            // Community Name
//            Text(community.communityName)
//                .font(.headline)
//                .padding(.top, 5)
//
//            // Members List
//            List {
//                ForEach(community.members, id: \.self) { member in
//                    HStack {
//                        Image(systemName: "person.circle")
//                            .foregroundColor(.black)
//                        Text(member)
//                            .font(.body)
//                        Spacer()
//                    }
//                    .padding(.vertical, 5)
//                }
//            }
//            .frame(height: 150) // Adjust list height
//
//            // Add Members Button
//            Button(action: {
//                // Add member action
//            }) {
//                Text("Add Members")
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            .padding(.horizontal, 20)
//
//            // Exit Button
//            Button(action: {
//                // Exit action
//            }) {
//                HStack {
//                    Image(systemName: "arrow.right.square")
//                    Text("Exit")
//                }
//                .frame(maxWidth: .infinity)
//                .padding()
//                .background(Color.white)
//                .foregroundColor(.red)
//                .cornerRadius(10)
//                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: 1))
//            }
//            .padding(.horizontal, 20)
//        }
//        .padding()
//        .navigationTitle("")
//        .navigationBarBackButtonHidden(true)
//        .navigationBarItems(leading: Button(action: {
//            presentationMode.wrappedValue.dismiss()
//        }) {
//            Text("Chats").foregroundColor(.blue)
//        })
//    }
//}
//


import SwiftUI

struct CommunityDetailsView: View {
    var community: CommunityCellModel
    @Binding var communities: [CommunityCellModel]
    
    @Environment(\.presentationMode) var presentationMode
    @State private var showExitAlert = false
    var body: some View {
        VStack(spacing: 16) { // Adjusted spacing for better layout
            
            // Community Image
            Image(community.communityImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 180, height: 180) // Increased size
                .clipShape(RoundedRectangle(cornerRadius: 20)) // Added rounded corners
                .padding(.top, 5) // Reduced top padding
            
            // Community Name
            Text(community.communityName)
                .font(.title2)
                .bold()
                .padding(.top, 2) // Minimized top padding
            
            // Members List
            List {
                ForEach(community.members, id: \.self) { member in
                    HStack {
                        Image(systemName: "person.circle")
                            .foregroundColor(.black)
                        Text(member)
                            .font(.body)
                        Spacer()
                    }
                    .padding(.vertical, 5)
                }
            }
            .frame(height: 250) // Increased List height
            .cornerRadius(12)

            // Buttons with adjusted spacing
            VStack(spacing: 20) { // Increased spacing
                NavigationLink(destination: AddMemberToCommunity(communityMembers: Binding(
                                    get: { community.members.map { Friend(name: $0, location: "") } },
                                    set: { newMembers in
                                        if let index = communities.firstIndex(where: { $0.id == community.id }) {
                                            communities[index].members = newMembers.map { $0.name }
                                        }
                                    }
                                ))) {
                    Text("Add Members")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action:{
                    showExitAlert = true
                }) {
                    HStack {
                        Image(systemName: "arrow.right.square")
                        Text("Exit")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.red)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: 1))
                }
                .alert(isPresented: $showExitAlert) {
                                    Alert(
                                        title: Text("Leave Community"),
                                        message: Text("Are you sure you want to leave this community?"),
                                        primaryButton: .destructive(Text("Leave")) {
                                            exitCommunity()
                                        },
                                        secondaryButton: .cancel()
                                    )
                                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10) // Increased spacing from the list
        }
        .padding(.top, 10) // Adjusted top padding for overall alignment
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
            Text("Chats").foregroundColor(.blue)
        })
    }
    private func exitCommunity() {
            communities.removeAll { $0.id == community.id }
            presentationMode.wrappedValue.dismiss()
        }

}
