import SwiftUI

struct ChangePasswordView: View {
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var isPasswordVisible: [Bool] = [false, false, false]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                PasswordField(label: "Current Password", text: $currentPassword, isVisible: $isPasswordVisible[0])
                PasswordField(label: "New Password", text: $newPassword, isVisible: $isPasswordVisible[1])
                PasswordField(label: "Confirm New Password", text: $confirmPassword, isVisible: $isPasswordVisible[2])
                
                Text("Your new password should be at least 8 characters long, contain a mix of uppercase and lowercase letters, numbers, and special symbols.")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Change Password")
            .navigationBarItems(
                trailing: Button("Done") {
                    handleChangePassword()
                }
            )
        }
    }
    
    private func handleChangePassword() {
        guard !newPassword.isEmpty else {
            showAlert(title: "Error", message: "Please enter a new password.")
            return
        }
        
        showConfirmationAlert()
    }
    
    private func showConfirmationAlert() {
        let alert = UIAlertController(title: "Are you sure?", message: "You are about to change your password. Do you want to proceed?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Yes", style: .default) { _ in
            showAlert(title: "Success", message: "Your password has been changed successfully.")
        })
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
    }
}

struct PasswordField: View {
    let label: String
    @Binding var text: String
    @Binding var isVisible: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .font(.headline)
                .foregroundColor(.gray)
            
            HStack {
                if isVisible {
                    TextField("", text: $text)
                } else {
                    SecureField("", text: $text)
                }
                
                Button(action: { isVisible.toggle() }) {
                    Image(systemName: isVisible ? "eye" : "eye.slash")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
