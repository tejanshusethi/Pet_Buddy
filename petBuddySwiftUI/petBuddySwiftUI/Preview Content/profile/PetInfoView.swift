import SwiftUI

struct PetInfoView: View {
    let pet: Pet  // ✅ Pet data now correctly passed via initializer

    var body: some View {
        VStack(spacing: 16) {
            if let uiImage = pet.image {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .shadow(radius: 5)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .shadow(radius: 5)
            }

            Text(pet.name)
                .font(.title2)
                .bold()
                .foregroundColor(.black)
                .multilineTextAlignment(.center)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                InfoTile(title: "Breed", subtitle: pet.breed, iconName: "pawprint.circle")
                InfoTile(title: "Age", subtitle: pet.age, iconName: "calendar")
                InfoTile(title: "Gender", subtitle: pet.gender, iconName: "person")
                InfoTile(title: "Size", subtitle: pet.size, iconName: "scalemass")
                InfoTile(title: "Hobby", subtitle: pet.hobby, iconName: "sportscourt")
            }
            .padding(.horizontal, 16)

            Spacer()
        }
        .padding(.top, 20)
        .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
    }
}

// MARK: - InfoTile (Reusable Component)
struct InfoTile: View {
    let title: String
    let subtitle: String
    let iconName: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: iconName)
                    .foregroundColor(.black)
                    .imageScale(.large)

                Text(title)
                    .font(.headline)
            }

            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 100)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}

// MARK: - Preview
struct PetInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PetInfoView(pet: Pet.mockPet)  // ✅ Passing mock data for preview
            .previewDevice("iPhone 14")
    }
}
