import SwiftUI

struct NotificationPreferencesView: View {
    @State private var notificationPreferences: [(title: String, symbol: String, isOn: Bool)] = [
        ("App Notifications", "app.badge", true),
        ("Mail Notifications", "envelope.fill", true),
        ("Reminder Notifications", "calendar.badge.clock", false)
    ]

    var body: some View {
        NavigationStack {
            List {
                ForEach(notificationPreferences.indices, id: \.self) { index in
                    HStack {
                        Image(systemName: notificationPreferences[index].symbol)
                            .foregroundColor(.black)
                        
                        Text(notificationPreferences[index].title)
                        
                        Spacer()
                        
                        Toggle("", isOn: $notificationPreferences[index].isOn)
                            .labelsHidden()
                    }
                    .padding(.vertical, 8)
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Notification Preferences")
                        .font(.headline) // Adjust font size
                        .foregroundColor(.primary)
                }
            }
        }
    }
}

struct NotificationPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationPreferencesView()
    }
}
