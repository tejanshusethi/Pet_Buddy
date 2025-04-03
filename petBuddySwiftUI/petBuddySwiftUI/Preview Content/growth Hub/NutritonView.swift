//
//  NutritonView.swift
//  petBuddySwiftUI
//

//
import SwiftUI

struct NutritionView: View {
    @State private var selectedTab = "Nutrition"
    @State private var selectedDate = Date()
    @State private var selectedDay = Calendar.current.component(.day, from: Date())
    
    @State private var meals = [
        Meal(imageName: "breakfast", name: "Breakfast", time: "8:00 AM", items: [
            MealItem(name: "Scrambled Eggs", calories: 180),
            MealItem(name: "Whole Wheat Toast", calories: 120)
        ], isCompleted: false),
        Meal(imageName: "lunch", name: "Lunch", time: "1:00 PM", items: [
            MealItem(name: "Chicken & Rice", calories: 350),
            MealItem(name: "Steamed Vegetables", calories: 120)
        ], isCompleted: false),
        Meal(imageName: "Evening Snacks", name: "Evening Snacks", time: "5:00 PM", items: [
            MealItem(name: "goodies", calories: 200),
            MealItem(name: "pedicare", calories: 250)
        ], isCompleted: false),
        Meal(imageName: "dinner", name: "Dinner", time: "7:00 PM", items: [
            MealItem(name: "Salmon Fillet", calories: 280),
            MealItem(name: "Quinoa Salad", calories: 200)
        ], isCompleted: false)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
//                        Text("Growth Hub")
//                            .font(.system(size: 32, weight: .bold))
//                            .foregroundColor(.primary)
                        
                        Text("Age: 6 months • Breed: German Shepherd")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    // Segmented Control
//                    SegmentedControlView(selectedTab: $selectedTab)
//                        .padding(.horizontal)
                    
                    // Calendar View
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Today's Plan")
                                .font(.headline)
                            
                            Spacer()
                            
                            // Week navigation
                            HStack(spacing: 20) {
                                Button {
                                    withAnimation {
                                        selectedDate = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: selectedDate) ?? selectedDate
                                    }
                                } label: {
                                    Image(systemName: "chevron.left")
                                        .font(.headline)
                                }
                                
                                Button {
                                    withAnimation {
                                        selectedDate = Date()
                                        selectedDay = Calendar.current.component(.day, from: Date())
                                    }
                                } label: {
                                    Text("Today")
                                        .font(.subheadline)
                                }
                                
                                Button {
                                    withAnimation {
                                        selectedDate = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: selectedDate) ?? selectedDate
                                    }
                                } label: {
                                    Image(systemName: "chevron.right")
                                        .font(.headline)
                                }
                            }
                            .foregroundColor(.blue)
                        }
                        .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(daysInWeek(for: selectedDate), id: \.self) { date in
                                    let day = Calendar.current.component(.day, from: date)
                                    let weekdaySymbols = Calendar.current.shortWeekdaySymbols
                                    let weekdayIndex = Calendar.current.component(.weekday, from: date) - 1
                                    let weekday = weekdaySymbols[weekdayIndex]
                                    let isToday = Calendar.current.isDate(date, inSameDayAs: Date())
                                    
                                    VStack(spacing: 6) {
                                        Text(weekday)
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(selectedDay == day ? .white : (isToday ? .blue : .secondary))
                                        
                                        Text("\(day)")
                                            .font(.system(size: 16, weight: .bold))
                                            .frame(width: 44, height: 44)
                                            .background(selectedDay == day ? Color.blue : (isToday ? Color.blue.opacity(0.1) : Color(.systemBackground)))
                                            .foregroundColor(selectedDay == day ? .white : (isToday ? .blue : .primary))
                                            .clipShape(Circle())
                                            .overlay(
                                                Circle()
                                                    .stroke(isToday ? Color.blue : Color.blue.opacity(selectedDay == day ? 0 : 0.3), lineWidth: 1)
                                            )
                                    }
                                    .frame(width: 50)
                                    .onTapGesture {
                                        withAnimation(.spring()) {
                                            selectedDay = day
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical, 12)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // Meals Section
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Today's Meals")
                                .font(.headline)
                            
                            Spacer()
                            
                            Text("\(totalCalories) kcal")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.horizontal)
                        
                        ForEach($meals) { $meal in
                            NavigationLink(destination: MealDetailView(meal: $meal)) {
                                MealCard(meal: meal)
                                    .padding(.horizontal)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.top, 8)
                }
                .padding(.bottom)
            }
            .background(Color(.systemGroupedBackground))
//            .navigationBarHidden(true)
            .navigationTitle("Growth Hub")
            
        }
    }
    
    private func daysInWeek(for date: Date) -> [Date] {
        let calendar = Calendar.current
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek) }
    }
    
    var totalCalories: Int {
        meals.flatMap { $0.items }.reduce(0) { $0 + $1.calories }
    }
}

struct Meal: Identifiable {
    let id = UUID()
    let imageName: String
    let name: String
    let time: String
    let items: [MealItem]
    var isCompleted: Bool
}

struct MealItem: Identifiable {
    let id = UUID()
    let name: String
    let calories: Int
}

struct SegmentedControlView: View {
    @Binding var selectedTab: String
    let tabs = ["Training", "Nutrition"]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs, id: \.self) { tab in
                Text(tab)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(selectedTab == tab ? .white : .secondary)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background(
                        ZStack {
                            if selectedTab == tab {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.blue)
                                    .shadow(color: Color.blue.opacity(0.2), radius: 4, x: 0, y: 2)
                            }
                        }
                    )
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.interactiveSpring()) {
                            selectedTab = tab
                        }
                    }
            }
        }
        .padding(4)
        .background(Color(.tertiarySystemBackground))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

struct MealCard: View {
    let meal: Meal
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 16) {
                Image(meal.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(.systemGray4), lineWidth: 0.5)
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(meal.name)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    Text(meal.time)
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                    
                    HStack(spacing: 6) {
                        if meal.items.count > 2 {
                            Text("+\(meal.items.count - 2) more")
                                .font(.system(size: 13))
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                Spacer()
                
                if meal.isCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .font(.system(size: 22))
                } else {
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color(.systemGray3))
                }
            }
            .padding()
        }
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 2)
    }
}

struct MealDetailView: View {
    @Binding var meal: Meal
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack(alignment: .top) {
                    Image(meal.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(meal.name)
                            .font(.title2.bold())
                        
                        Text(meal.time)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Text("\(meal.items.reduce(0) { $0 + $1.calories }) kcal")
                            .font(.subheadline.bold())
                            .foregroundColor(.blue)
                    }
                    .padding(.leading, 8)
                    
                    Spacer()
                }
                .padding(.bottom, 8)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Meal Items")
                        .font(.headline)
                    
                    ForEach(meal.items) { item in
                        HStack {
                            Text(item.name)
                            
                            Spacer()
                            
                            Text("\(item.calories) kcal")
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 8)
                    }
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Notes")
                        .font(.headline)
                    
                    Text("Make sure to measure portions accurately. The puppy should have access to fresh water at all times.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
            }
            .padding()
        }
        .navigationTitle(meal.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                    meal.isCompleted = true
                    dismiss()
                }
            }
        }
        .background(Color(.systemGroupedBackground))
    }
}

struct GrowthHubView1_Previews: PreviewProvider {
    static var previews: some View {
        NutritionView()
    }
}
