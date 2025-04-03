import SwiftUI

struct InformationLoginView: View {
    @State private var breed: String = UserDefaults.standard.string(forKey: "breed") ?? ""
    @State private var ageText: String = UserDefaults.standard.string(forKey: "age") ?? ""
    @State private var gender: String = UserDefaults.standard.string(forKey: "gender") ?? ""
    @State private var size: String = UserDefaults.standard.string(forKey: "size") ?? ""
    @State private var hobby: String = UserDefaults.standard.string(forKey: "hobby") ?? ""
    
    @State private var selectedImage: UIImage?
    @State private var showImagePicker = false
    @State private var navigateToContentView = false // Navigation state

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Profile Image
                ZStack {
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                    }
                }
                .onTapGesture { showImagePicker = true }

                Text("Add Photo")
                    .foregroundColor(.blue)
                    .onTapGesture { showImagePicker = true }

                // Input Fields
                DogInfoTextField(placeholder: "Dog's Breed", text: $breed)
                DogInfoTextField(placeholder: "Age", text: $ageText, keyboardType: .numberPad)
                DogInfoTextField(placeholder: "Gender", text: $gender)
                DogInfoTextField(placeholder: "Size", text: $size)
                DogInfoTextField(placeholder: "Hobby", text: $hobby)

                // Done Button
                // Done Button
                Button("Done") {
                    savePetData()
                    navigateToContentView = true // Trigger navigation
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(8)

                // Hidden NavigationLink to MainView without Back Button
                NavigationLink(
                    destination: MainView()
                        .navigationBarBackButtonHidden(true), // Hide back button only// Ensure title is visible
                    isActive: $navigateToContentView
                ) {
                    EmptyView()
                }
                .hidden()


                
                Spacer()
            }
            .padding()
            .sheet(isPresented: $showImagePicker) {
                ImagePickerView(selectedImage: $selectedImage)
            }
        }
    }

    // Function to save pet data
    private func savePetData() {
        UserDefaults.standard.setValue(breed, forKey: "breed")
        UserDefaults.standard.setValue(ageText, forKey: "age")
        UserDefaults.standard.setValue(gender, forKey: "gender")
        UserDefaults.standard.setValue(size, forKey: "size")
        UserDefaults.standard.setValue(hobby, forKey: "hobby")
        
        if let image = selectedImage, let imageData = image.jpegData(compressionQuality: 0.8) {
            UserDefaults.standard.setValue(imageData, forKey: "petImage")
        }
    }
}

// MARK: - Custom TextField for Dog Info
struct DogInfoTextField: View {
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(placeholder)
                .foregroundColor(.gray)
                .font(.subheadline)

            TextField(placeholder, text: $text)
                .keyboardType(keyboardType)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding(.horizontal)
    }
}

// MARK: - Image Picker
struct ImagePickerView: UIViewControllerRepresentable {
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

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePickerView

        init(_ parent: ImagePickerView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.selectedImage = uiImage
            }
            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}

// MARK: - Preview
struct InformationLoginView_Previews: PreviewProvider {
    static var previews: some View {
        InformationLoginView()
            .previewDevice("iPhone 14")
    }
}
