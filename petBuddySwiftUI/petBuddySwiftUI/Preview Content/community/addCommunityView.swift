//
//  addCommunityView.swift
//  petBuddySwiftUI
//
//  Created by NITIN KALIRAMAN on 24/03/25.
//

//import SwiftUI
//
//struct AddCommunityView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @Binding var publicCommunities: [CommunityCellModel]
//    @Binding var privateCommunities: [CommunityCellModel]
//
//    @State private var communityName = ""
//    @State private var description = ""
//    @State private var isPublic = true
//    @State private var selectedImage: UIImage? = nil
//    @State private var showImagePicker = false
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                // Profile Image Picker
//                Button(action: { showImagePicker = true }) {
//                    if let image = selectedImage {
//                        Image(uiImage: image)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 100, height: 100)
//                            .clipShape(Circle())
//                    } else {
//                        Image(systemName: "plus")
//                            .resizable()
//                            .frame(width: 40, height: 40)
//                            .foregroundColor(.gray)
//                            .padding()
//                            .background(Circle().fill(Color(.systemGray5)))
//                    }
//                }
//                .padding(.top)
//                .sheet(isPresented: $showImagePicker) {
//                    ImagePicker(selectedImage: $selectedImage)
//                }
//
//                Text("Add Photo")
//                    .foregroundColor(.blue)
//
//                // Community Name
//                TextField("Community Name", text: $communityName)
//                    .padding()
//                    .background(Color(.systemGray6))
//                    .cornerRadius(8)
//                    .padding(.horizontal)
//
//                // Description
//                TextField("Description", text: $description)
//                    .padding()
//                    .background(Color(.systemGray6))
//                    .cornerRadius(8)
//                    .padding(.horizontal)
//
//                // Public Toggle
//                Toggle("Public", isOn: $isPublic)
//                    .padding()
//
//                Spacer()
//            }
//            .navigationTitle("Add New Community")
//            .toolbar {
//                ToolbarItem(placement: .cancellationAction) {
//                    Button("Cancel") {
//                        presentationMode.wrappedValue.dismiss()
//                    }
//                }
//                ToolbarItem(placement: .confirmationAction) {
//                    Button("Done") {
//                        addCommunity()
//                        presentationMode.wrappedValue.dismiss()
//                    }
//                    .disabled(communityName.isEmpty) // Disable if name is empty
//                }
//            }
//        }
//    }
//
//    // Function to add a new community
//    private func addCommunity() {
//        let newCommunity = CommunityCellModel(
//            communityName: communityName,
//            communityImageName: selectedImage != nil ? "custom_image" : "default_community", // Placeholder for now
//            description: description,
//            members: [],
//            chatMessages: []
//        )
//
//        if isPublic {
//            publicCommunities.append(newCommunity)
//        } else {
//            privateCommunities.append(newCommunity)
//        }
//    }
//}
//
//// Image Picker for selecting a community image
//struct ImagePicker: UIViewControllerRepresentable {
//    @Binding var selectedImage: UIImage?
//    
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.delegate = context.coordinator
//        picker.sourceType = .photoLibrary
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
//
//    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//        let parent: ImagePicker
//
//        init(_ parent: ImagePicker) {
//            self.parent = parent
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//            if let image = info[.originalImage] as? UIImage {
//                parent.selectedImage = image
//            }
//            picker.dismiss(animated: true)
//        }
//    }
//}


import SwiftUI

struct AddCommunityView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var publicCommunities: [CommunityCellModel]
    @Binding var privateCommunities: [CommunityCellModel]
    @State private var communityName = ""
    @State private var description = ""
    @State private var isPublic = true
    @State private var selectedImage: UIImage? = nil
    @State private var showImagePicker = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) { // Increased spacing between elements
                // Profile Image Picker
                Button(action: { showImagePicker = true }) {
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120) // Increased size
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 50, height: 50) // Increased size
                            .foregroundColor(.gray)
                            .padding(30) // Increased padding for a larger circle
                            .background(Circle().fill(Color(.systemGray5)))
                    }
                }
                .padding(.top, 20) // Added some top padding
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(selectedImage: $selectedImage)
                }

                Text("Add Photo")
                    .foregroundColor(.blue)
                    .font(.headline) // Made the text a little bigger

                // Community Name
                VStack(spacing: 12) { // Added more spacing between text fields
                    TextField("Community Name", text: $communityName)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)

                    // Description
                    TextField("Description", text: $description)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)
                }

                // Public Toggle with extra spacing
                Toggle("Public", isOn: $isPublic)
                    .padding()
                    .padding(.top, 10) // Added top padding to increase spacing

                Spacer()
            }
            .navigationTitle("Add New Community")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        addCommunity()
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(communityName.isEmpty) // Disable if name is empty
                }
            }
        }
    }

    private func addCommunity() {
        let newCommunity = CommunityCellModel(
            communityName: communityName,
            communityImageName: selectedImage, // Pass the selected image
            description: description,
            members: [],
            chatMessages: []
        )

        if isPublic {
            publicCommunities.append(newCommunity)
        } else {
            privateCommunities.append(newCommunity)
        }
    }

}

// Image Picker for selecting a community image
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            picker.dismiss(animated: true)
        }
    }
}
