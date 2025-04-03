import SwiftUI

struct ForgotPasswordView: View {
    @State private var email = ""
    @State private var otp = Array(repeating: "", count: 6)
    @FocusState private var focusedField: Int?
    @State private var showAlert = false
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var navigateToHome = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image("petlogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding(.top, 40)

                VStack(alignment: .leading) {
                    Text("E-mail")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    TextField("Enter your email", text: $email)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray, lineWidth: 1))
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }
                .padding(.horizontal, 30)

                VStack(alignment: .leading) {
                    Text("Enter the OTP sent")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)

                    HStack(spacing: 10) {
                        ForEach(0..<6, id: \.self) { index in
                            TextField("", text: $otp[index])
                                .frame(width: 40, height: 40)
                                .background(RoundedRectangle(cornerRadius: 5).stroke(Color.gray))
                                .multilineTextAlignment(.center)
                                .keyboardType(.numberPad)
                                .focused($focusedField, equals: index)
                                .onChange(of: otp[index]) { newValue in
                                    handleOTPChange(index: index, value: newValue)
                                }
                        }
                    }
                }
                .padding(.horizontal, 30)

                HStack {
                    Spacer()
                    Button("Send OTP") {
                        sendOTPWithSendGrid(email: email)
                        showAlert = true
                    }
                    .font(.system(size: 14))
                    .foregroundColor(.blue)
                    .alert("OTP Sent Successfully", isPresented: $showAlert) {
                        Button("OK", role: .cancel) { }
                    }
                }
                .padding(.horizontal, 30)

                Button("Log In") {
                    verifyOTP(email: email, otp: getOTP())
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal, 30)
                .navigationDestination(isPresented: $navigateToHome) {
                    HomeScreen()
                }

                if showError {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.system(size: 14))
                        .padding(.top, 5)
                }

                Spacer()
            }
            .padding()
        }
    }

    // Updated OTP Input Handling with Correct Focus Movement
    func handleOTPChange(index: Int, value: String) {
        let filteredValue = value.filter { $0.isNumber }
        
        if !filteredValue.isEmpty {
            otp[index] = String(filteredValue.prefix(1))
            
            // Move to the next field if a digit is entered and it's not the last field
            if index < 5 {
                DispatchQueue.main.async {
                    focusedField = index + 1
                }
            }
        } else {
            otp[index] = ""

            // Move back on delete if not at the first field
            if index > 0 {
                DispatchQueue.main.async {
                    focusedField = index - 1
                }
            }
        }

        // Auto-submit when all fields are filled
        if getOTP().count == 6 {
            verifyOTP(email: email, otp: getOTP())
        }
    }

    func sendOTPWithSendGrid(email: String) {
        let otpCode = String(Int.random(in: 100000...999999))
        let url = URL(string: "https://api.sendgrid.com/v3/mail/send")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer YOUR_SENDGRID_API_KEY", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "personalizations": [["to": [["email": email]]]],
            "from": ["email": "your-email@example.com"],
            "subject": "Your OTP Code",
            "content": [["type": "text/plain", "value": "Your OTP is \(otpCode)"]]
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { _, response, error in
            DispatchQueue.main.async {
                if error != nil {
                    showError = true
                    errorMessage = "Failed to send OTP"
                }
            }
        }.resume()
    }

    func verifyOTP(email: String, otp: String) {
        guard !otp.isEmpty else {
            showError = true
            errorMessage = "Please enter the OTP"
            return
        }
        if otp == "123456" { // Replace with backend validation
            showError = false
            navigateToHome = true
        } else {
            showError = true
            errorMessage = "Invalid OTP"
        }
    }

    func getOTP() -> String {
        return otp.joined()
    }
}

struct HomeScreen: View {
    var body: some View {
        Text("Welcome to Home Screen!")
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
