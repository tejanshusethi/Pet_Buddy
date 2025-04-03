import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var isLoginSuccessful: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var navigateToForgotPassword = false
    @State private var navigateToOwnerInfo = false

    var isFormValid: Bool {
        !email.isEmpty && !password.isEmpty
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Logo
                Image("petlogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding(.top, 50)
                
                // Email Field
                VStack(alignment: .leading, spacing: 5) {
                    Text("E-mail")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    TextField("Enter your email", text: $email)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                }
                .padding(.horizontal)
                
                // Password Field
                VStack(alignment: .leading, spacing: 5) {
                    Text("Password")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    HStack {
                        if isPasswordVisible {
                            TextField("Enter your password", text: $password)
                        } else {
                            SecureField("Enter your password", text: $password)
                        }
                        
                        Button(action: { isPasswordVisible.toggle() }) {
                            Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
                .padding(.horizontal)
                
                // Forgot Password Button
                Button(action: { navigateToForgotPassword = true }) {
                    Text("Forgot Your Password?")
                        .foregroundColor(.blue)
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                }
                .padding(.top, 10)
                
                // Login Button
                Button(action: handleLogin) {
                    Text("Log In")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isFormValid ? Color.blue : Color.gray.opacity(0.5))
                        .cornerRadius(10)
                }
                .disabled(!isFormValid)
                .padding(.horizontal)
                .padding(.top, 15)
                
                // OR Separator
                HStack {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0.5))
                    Text("OR")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                // Sign Up Button
                Button(action: { navigateToOwnerInfo = true }) {
                    Text("Don't have an Account? Sign Up")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                Spacer()
            }
            .padding(.top)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Login Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .fullScreenCover(isPresented: $isLoginSuccessful) {
                MainView() // Replaces login screen
            }
            .navigationDestination(isPresented: $navigateToForgotPassword) {
                ForgotPasswordView()
            }
            .navigationDestination(isPresented: $navigateToOwnerInfo) {
                OwnerInfoView()
            }
        }
    }

    private func handleLogin() {
        if email.lowercased() == "user@gmail.com" && password == "password" {
            isLoginSuccessful = true
        } else {
            alertMessage = "Invalid email or password."
            showAlert = true
        }
    }
}

// Preview
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
