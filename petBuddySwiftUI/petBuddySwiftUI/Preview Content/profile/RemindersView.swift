import SwiftUI
import Foundation


struct ReminderView: View {
    @EnvironmentObject var reminderVM: ReminderViewModel
    @State private var showAddReminder = false

    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Active Reminders")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                ) {
                    ForEach(reminderVM.reminders) { reminder in
                        VStack(alignment: .leading) {
                            Text(reminder.reminderName)
                                .font(.headline)
                            Text(reminder.upcomingEvents)
                                .font(.subheadline)
                                .foregroundColor(.blue)
                            Text(reminder.reminderDescription)
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 4)
                    }
                    .onDelete(perform: reminderVM.deleteReminder)
                }
            }
            .navigationTitle("Reminders")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showAddReminder.toggle() }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddReminder) {
                AddReminderView { name, event, description in
                    let newReminder = Reminder(reminderName: name, upcomingEvents: event, reminderDescription: description)
                    reminderVM.addReminder(newReminder)
                }
            }
        }
    }
}
    struct RemindersView_Previews: PreviewProvider {
        static var previews: some View {
            RemindersView()
        }
    }

