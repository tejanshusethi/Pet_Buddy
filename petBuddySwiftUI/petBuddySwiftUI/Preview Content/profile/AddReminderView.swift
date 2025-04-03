//
//  AddReminderView.swift
//  petBuddySwiftUI
//
//  Created by NITIN KALIRAMAN on 27/03/25.
//

import SwiftUI

struct AddReminderView: View {
    @Environment(\.dismiss) var dismiss
    @State private var reminderName: String = ""
    @State private var selectedDate = Date()
    @State private var reminderDescription: String = ""

    var onSave: (String, String, String) -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Reminder Details")) {
                    TextField("Reminder Name", text: $reminderName)
                    DatePicker("Upcoming Event", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                    TextField("Description", text: $reminderDescription)
                }
            }
            .navigationTitle("Add Reminder")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "MMMM d, yyyy 'at' h:mm a"
                        let formattedDate = dateFormatter.string(from: selectedDate)

                        onSave(reminderName, formattedDate, reminderDescription)
                        dismiss()
                    }
                    .disabled(reminderName.isEmpty || reminderDescription.isEmpty)
                }
            }
        }
    }
}
