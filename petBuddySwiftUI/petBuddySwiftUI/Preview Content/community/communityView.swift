



import SwiftUI

// Data Model
struct ChatMessage {
    var id = UUID()
    let username: String
    let message: String
}
struct FriendRequest: Identifiable {
    let id = UUID()
    let username: String
    var isAccepted: Bool = false
}
struct CommunityCellModel: Identifiable {
    let id = UUID()
    var communityName: String
    var communityImage: UIImage? // Changed from String to UIImage?
    var description: String
    var members: [String]
    var chatMessages: [ChatMessage]
}


// Main Community View
struct CommunityView: View {
    @State private var selectedSegment = "Public"
    @State private var searchText = "" // Search Input
    @State private var showAddCommunityView = false
    @State private var showAddFriendView = false

    // Sample Data
    @State private var publicCommunities: [CommunityCellModel] = [
        CommunityCellModel(
            communityName: "Model Town",
            communityImage: UIImage(named: "Modeltown"), // Load UIImage
            description: "A vibrant neighborhood community.",
            members: ["Alice", "Bob", "Charlie"],
            chatMessages: [ChatMessage(username: "Alice", message: "Welcome!")]
        ),
        CommunityCellModel(
            communityName: "German Shepherd Club",
            communityImage: UIImage(named: "Germanshephard"), // Load UIImage
            description: "For German Shepherd dog lovers.",
            members: ["David", "Emma", "Frank"],
            chatMessages: [ChatMessage(username: "David", message: "Let's talk about training!")]
        )
    ]

    @State private var suggestedCommunities: [CommunityCellModel] = [
        CommunityCellModel(
            communityName: "Sec-34 Neighborhood",
            communityImage: UIImage(named: "sec-34"), // Load UIImage
            description: "A private neighborhood discussion group.",
            members: ["George", "Harry"],
            chatMessages: []
        ),
        CommunityCellModel(
            communityName: "Chitkara University",
            communityImage: UIImage(named: "chitkara"), // Load UIImage
            description: "University alumni and student group.",
            members: ["Irene", "Jack"],
            chatMessages: []
        )
    ]

    @State private var privateCommunities: [CommunityCellModel] = [
        CommunityCellModel(
            communityName: "Tech Innovators",
            communityImage: UIImage(named: "friends"), // Load UIImage
            description: "For tech enthusiasts and developers.",
            members: ["Liam", "Sophia"],
            chatMessages: [ChatMessage(username: "Liam", message: "What’s the latest AI trend?")]
        )
    ]

    
    var filteredPublicCommunities: [CommunityCellModel] {
            searchText.isEmpty ? publicCommunities :
            publicCommunities.filter { $0.communityName.localizedCaseInsensitiveContains(searchText) }
        }

        var filteredPrivateCommunities: [CommunityCellModel] {
            searchText.isEmpty ? privateCommunities :
            privateCommunities.filter { $0.communityName.localizedCaseInsensitiveContains(searchText) }
        }
    
    var body: some View {
        NavigationStack {
            VStack {
                // Search Bar
                TextField("Search Communities", text: $searchText)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                // Segmented Control
                Picker("Select", selection: $selectedSegment) {
                    Text("Public").tag("Public")
                    Text("Private").tag("Private")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                // List of Communities
                List {
                    if selectedSegment == "Public" {
                        PublicCommunityListView(
                            communities: filteredPublicCommunities, // Pass filtered communities
                            allCommunities: $publicCommunities,
                            suggestedCommunities: $suggestedCommunities
                        )
                    } else {
                        PrivateCommunityListView(communities: filteredPrivateCommunities,allCommunities: $privateCommunities)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Community")
            .toolbar {
                ToolbarContentView(showAddCommunityView: $showAddCommunityView, showAddFriendView: $showAddFriendView)
            }
            .sheet(isPresented: $showAddCommunityView) {
                AddCommunityView(publicCommunities: $publicCommunities, privateCommunities: $privateCommunities)
            }
            .sheet(isPresented: $showAddFriendView) {
                            AddFriendView(privateChats: $privateCommunities)
                        }
        }
    }
}

// Public Community List with Search Support
struct PublicCommunityListView: View {
    var communities: [CommunityCellModel] // Use filtered list
        @Binding var allCommunities: [CommunityCellModel]
    @Binding var suggestedCommunities: [CommunityCellModel]
    
    var body: some View {
        // Public Groups Section
        Section(header: Text("Groups").font(.headline).foregroundColor(.gray)) {
            ForEach(communities) { community in
                NavigationLink(destination: CommunityChatsView(community: community,communities: $allCommunities)) {
                    CommunityRowView(community: community)
                }
            }
        }
        
        // Suggested Groups Section
        Section(header: Text("Suggested Groups").font(.headline).foregroundColor(.gray)) {
            ForEach(suggestedCommunities) { community in
                HStack {
                    CommunityRowView(community: community)
                    
                    Button(action: {
                        addToPublicCommunities(community)
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.blue)
                    }
                }
            }
        }
    }
    
    // Function to add suggested community to public list
    private func addToPublicCommunities(_ community: CommunityCellModel) {
            if !allCommunities.contains(where: { $0.id == community.id }) {
                allCommunities.append(community) // Add to Public
                suggestedCommunities.removeAll(where: { $0.id == community.id }) // Remove from Suggested
            }
        }
}

// Private Community List with Search Support
struct PrivateCommunityListView: View {
    var communities: [CommunityCellModel] // Use filtered list

    @Binding var allCommunities: [CommunityCellModel]
    
    
    var body: some View {
        Section(header: Text("Private Groups").font(.headline).foregroundColor(.gray)) {
            ForEach(communities) { community in
                NavigationLink(destination: CommunityChatsView(community: community,communities: $allCommunities)) {
                    CommunityRowView(community: community)
                }
            }
        }
    }
}

// Toolbar
struct ToolbarContentView: View {
    @Binding var showAddCommunityView: Bool
    @Binding var showAddFriendView: Bool
    var body: some View {
        
        HStack {
            Button(action: { showAddFriendView = true }) {
                Image(systemName: "person.badge.plus")
                    .foregroundColor(.blue)
            }
            Button(action: { showAddCommunityView = true }) {
                Image(systemName: "plus")
                    .foregroundColor(.blue)
            }
        }
    }
}

// Community Row View
struct CommunityRowView: View {
    let community: CommunityCellModel
    
    HStack {
        if let image = community.communityImage {
            Image(uiImage: image)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        } else {
            Image(systemName: "photo") // Placeholder image
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .foregroundColor(.gray)
        }

        VStack(alignment: .leading) {
            Text(community.communityName)
                .font(.headline)
                .foregroundColor(.black)
            Text("\(community.members.count) members")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        Spacer()
    }

    
}

// Chat View
struct CommunityChatView: View {
    var community: CommunityCellModel
    
    var body: some View {
        VStack {
            List(community.chatMessages, id: \.username) { message in
                HStack {
                    VStack(alignment: .leading) {
                        Text(message.username)
                            .font(.headline)
                        Text(message.message)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding(5)
            }
        }
        .navigationTitle(community.communityName)
    }
}

// Preview
struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView()
    }
}
