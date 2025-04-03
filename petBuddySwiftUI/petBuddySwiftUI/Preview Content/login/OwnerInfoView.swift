import SwiftUI

struct OwnerInfoView: View {
    @State private var ownerName = ""
    @State private var dogName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var navigateToNext = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image("petlogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.top, 10)
                    .frame(maxWidth: .infinity)
                
                VStack(spacing: 15) {
                    CustomTextField(placeholder: "Owner Name", text: $ownerName)
                    CustomTextField(placeholder: "Dog Name", text: $dogName)
                    CustomTextField(placeholder: "Enter Your Email", text: $email, keyboardType: .emailAddress)
                    CustomSecureField(placeholder: "Password", text: $password)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                Button(action: validateAndProceed) {
                    Text("Next")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.horizontal, 20)
                .padding(.top, 30)
                
                NavigationLink(destination: InformationLoginView(), isActive: $navigateToNext) {
                    EmptyView()
                }
                
                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func validateAndProceed() {
        if ownerName.isEmpty || dogName.isEmpty || email.isEmpty || password.isEmpty {
            showAlert(title: "Missing Information", message: "Please fill out all the fields.")
            return
        }
        
        if !isValidEmail(email) {
            showAlert(title: "Invalid Email", message: "Please enter a valid email address.")
            return
        }
        
        navigateToNext = true
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(placeholder)
                .foregroundColor(.gray)
                .font(.subheadline)
            TextField(placeholder, text: $text)
                .keyboardType(keyboardType)
                .padding(10)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
        }
    }
}

struct CustomSecureField: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(placeholder)
                .foregroundColor(.gray)
                .font(.subheadline)
            SecureField(placeholder, text: $text)
                .padding(10)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
        }
    }
}

struct OwnerInfoView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerInfoView()
    }
}
