import SwiftUI
import PhotosUI

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    @State private var profileImage: UIImage? = nil
    @State private var selectedImage: PhotosPickerItem? = nil
    @State private var name: String = "Bruno"
    @State private var showLogoutAlert = false
    @State private var isLoggedOut = false  // Controls navigation to LoginView
    
    let sectionTitles = ["User Information", "General"]
    let sectionItems = [
        ["Pet Information"],
        ["Change Password", "Notification Preference", "Reminders"]
    ]
    let cellIcons = [
        ["list.bullet.clipboard", "heart"],
        ["lock", "bell", "alarm"]
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    ProfileImageView(profileImage: $profileImage, selectedImage: $selectedImage)
                    Text(name)
                        .font(.title2)
                        .bold()
                        .padding(.top, 8)
                }
                .padding(.top, 20)
                
                List {
                    ForEach(0..<sectionTitles.count, id: \.self) { section in
                        Section(header: Text(sectionTitles[section])) {
                            ForEach(0..<sectionItems[section].count, id: \.self) { row in
                                NavigationLink(destination: destinationView(for: section, row: row)) {
                                    HStack {
                                        Image(systemName: cellIcons[section][row])
                                            .foregroundColor(.blue)
                                        Text(sectionItems[section][row])
                                    }
                                }
                            }
                        }
                        .listRowBackground(Color.white)
                    }
                    
                    Section {
                        Button(action: { showLogoutAlert = true }) {
                            Text("Logout")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(10)
                        }
                    }
                    .listRowBackground(Color.white)
                }
                .background(Color.white)
            }
            .navigationTitle("Profile")
            .background(Color.white)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                    }
                }
            }
            .alert("Are you sure you want to logout?", isPresented: $showLogoutAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Logout", role: .destructive) { logout() }
            }
            .fullScreenCover(isPresented: $isLoggedOut) {
                LoginView()
                    .navigationBarBackButtonHidden(true) // Prevents back navigation
            }
        }
    }
    
    private func destinationView(for section: Int, row: Int) -> some View {
        switch (section, row) {
        case (0, 0): return AnyView(PetInfoView(pet: Pet.mockPet))
        case (1, 0): return AnyView(ChangePasswordView())
        case (1, 1): return AnyView(NotificationPreferencesView())
        case (1, 2): return AnyView(ReminderView())
        default: return AnyView(EmptyView())
        }
    }
    
    private func logout() {
        isLoggedOut = true // Redirects to LoginView
    }
}

struct ProfileImageView: View {
    @Binding var profileImage: UIImage?
    @Binding var selectedImage: PhotosPickerItem?
    
    var body: some View {
        VStack {
            PhotosPicker(selection: $selectedImage, matching: .images) {
                if let image = profileImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .shadow(radius: 5)
                } else {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 100, height: 100)
                        .overlay(Image(systemName: "camera.fill").foregroundColor(.white))
                }
            }
            .buttonStyle(PlainButtonStyle())
            .onChange(of: selectedImage) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        profileImage = UIImage(data: data)
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
