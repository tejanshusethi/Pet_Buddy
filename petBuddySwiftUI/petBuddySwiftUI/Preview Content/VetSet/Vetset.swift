import SwiftUI

struct Vetset: View {
    @State private var searchText = ""
    
    let clinics = [
        ("Cvd Nadiali", "Ram Mehar Marg, Patiala", "5.0", "clinic1", "9876543210"),
        ("Healthy Paws Clinic", "Yps Market, Patiala", "5.0", "clinic1", "9123456789"),
        ("Passionate Paws Clinic", "ITI Road, Patiala", "5.0", "clinic1", "9000000000")
    ]
    
    var filteredClinics: [(String, String, String, String, String)] {
        if searchText.isEmpty {
            return clinics
        } else {
            return clinics.filter { $0.0.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 5) { // ✅ Reduced spacing
                SearchBar(text: $searchText)
                List {
                    ForEach(filteredClinics, id: \.4) { clinic in
                        ClinicRow(clinic: clinic)
                            .listRowSeparator(.visible)
                    }
                }
                .listStyle(PlainListStyle()) // ✅ Removes extra padding around list
            }
            .navigationTitle("VetSet")
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("Search clinics", text: $text)
                .autocapitalization(.none)
                .disableAutocorrection(true)
        }
        .padding(8) // ✅ Reduced padding
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .padding(.horizontal, 10) // ✅ Reduced horizontal padding
    }
}

struct ClinicRow: View {
    let clinic: (String, String, String, String, String)
    
    var body: some View {
        VStack {
            HStack {
                Image("clinic1")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.blue)
                
                VStack(alignment: .leading) {
                    Text(clinic.0).font(.headline)
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(.gray)
                        Text(clinic.1)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Text("⭐ \(clinic.2)").foregroundColor(.green)
                }
                Spacer()
                
                Button(action: {
                    let phoneNumber = clinic.4
                    print("Button tapped for \(phoneNumber)")

                    if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    } else {
                        print("Cannot make a call.")
                    }
                }) {
                    Text("Call")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .buttonStyle(BorderlessButtonStyle())
                .contentShape(Rectangle())
            }
            .padding(.vertical, 5)
            
            Divider()
        }
    }
}

struct VetClinicView_Previews: PreviewProvider {
    static var previews: some View {
        Vetset()
    }
}
