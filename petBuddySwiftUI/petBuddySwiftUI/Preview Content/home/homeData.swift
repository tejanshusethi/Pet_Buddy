//
//  homeData.swift
//  petBuddySwiftUI
//
//  Created by NITIN KALIRAMAN on 22/03/25.
//

import Foundation
import SwiftUI
struct Memories {
    var image: UIImage!
}

struct Reminder : Identifiable{
    let id = UUID()
    var reminderName: String
    var upcomingEvents: String
    var reminderDescription: String
}

struct CareTips {
    var careImage: UIImage!
    var careTitle: String
    var careDescription: String
    var careInfo: CareInfo
}

struct CareInfo {
    var image: String
    var tips: [String]
    var benefits: [String]
}



struct DataProvider {
    static let memories: [Memories] = [
        Memories(image: UIImage(named: "Germanshephard")),
        Memories(image: UIImage(named: "memory2")),
        Memories(image: UIImage(named: "memory3"))
    ]

    static let reminders: [Reminder] = [
        Reminder(reminderName: "Vet Visit", upcomingEvents: "March 25, 2025", reminderDescription: "Annual check-up appointment."),
        Reminder(reminderName: "Grooming", upcomingEvents: "February 28, 2025", reminderDescription: "Schedule a grooming session."),
        Reminder(reminderName: "Vaccination", upcomingEvents: "April 5, 2025", reminderDescription: "Rabies booster shot due.")
    ]

    static let careTips: [CareTips] = [
        CareTips(
            careImage: UIImage(named: "healthy_diet"),
            careTitle: "Healthy Diet",
            careDescription: "Ensure a balanced diet for your pet.",
            careInfo: CareInfo(
                image: "food_icon",
                tips: ["Provide fresh water daily", "Avoid overfeeding", "Include proteins and vitamins"],
                benefits: ["Improves digestion", "Boosts immunity", "Maintains healthy weight"]
            )
        ),
        CareTips(
            careImage: UIImage(named: "leash_training"),
            careTitle: "Regular Exercise",
            careDescription: "Daily activity is crucial for your pet.",
            careInfo: CareInfo(
                image: "exercise_icon",
                tips: ["Daily walks", "Interactive playtime", "Training sessions"],
                benefits: ["Strengthens muscles", "Prevents obesity", "Enhances mood"]
            )
        )
    ]
}
