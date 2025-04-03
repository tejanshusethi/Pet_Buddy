//
//  ReminderViewModel.swift
//  petBuddySwiftUI
//
//  Created by NITIN KALIRAMAN on 27/03/25.
//

import Foundation

class ReminderViewModel: ObservableObject {
    @Published var reminders: [Reminder] = [
        Reminder(reminderName: "Vet Visit", upcomingEvents: "March 25, 2025", reminderDescription: "Annual check-up appointment."),
        Reminder(reminderName: "Grooming", upcomingEvents: "February 28, 2025", reminderDescription: "Schedule a grooming session."),
        Reminder(reminderName: "Vaccination", upcomingEvents: "April 5, 2025", reminderDescription: "Rabies booster shot due.")
    ]

    func addReminder(_ reminder: Reminder) {
        reminders.append(reminder)
    }

    func deleteReminder(at offsets: IndexSet) {
        reminders.remove(atOffsets: offsets)
    }
}
