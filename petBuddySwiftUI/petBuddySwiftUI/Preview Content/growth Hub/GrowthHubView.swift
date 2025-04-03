//
//  GrowthHubView.swift
//  petBuddySwiftUI
//


import SwiftUI

struct GrowthHubView: View {
    @State private var selectedCategory = "Training"
    
    @State private var trainingSessions = [
        trainingSession1,bestTrainerTrainingSession
    ]
    
    @State private var exploreCourses = [
        newDogTrainingSession
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
//                Text("Growth Hub")
//                    .font(.largeTitle)
//                    .bold()
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.leading)
                
                Picker("Category", selection: $selectedCategory) {
                    Text("Training").tag("Training")
                    Text("Nutrition").tag("Nutrition")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                if selectedCategory == "Training" {
                                    List {
                                        Section(header: Text("Ongoing Courses").font(.headline).foregroundColor(.gray)) {
                                            ForEach(trainingSessions, id: \.trainingTitle) { session in
                                                NavigationLink(destination: BestTrainerTrainingSessionView(session: session)) {
                                                    HStack {
                                                        Image(session.trainingImage)
                                                            .resizable()
                                                            .frame(width: 50, height: 50)
                                                            .cornerRadius(10)
                                                        Text(session.trainingTitle)
                                                            .font(.headline)
                                                    }
                                                }
                                            }
                                        }
                                        
                                        Section(header: Text("Explore Courses").font(.headline).foregroundColor(.gray)) {
                                            ForEach(exploreCourses, id: \.trainingTitle) { course in
                                                NavigationLink(destination: TrainingSessionView(session: course, trainingSessions: $trainingSessions, exploreCourses: $exploreCourses)) {
                                                    HStack {
                                                        Image(course.trainingImage)
                                                            .resizable()
                                                            .frame(width: 50, height: 50)
                                                            .cornerRadius(10)
                                                        VStack(alignment: .leading) {
                                                            Text(course.trainingTitle)
                                                                .font(.headline)
                                                            Text(course.trainingSubtitle)
                                                                .font(.subheadline)
                                                                .foregroundColor(.gray)
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                } else {
                                    // Show NutritionView when "Nutrition" is selected
                                    NutritionView()
                                        .transition(.slide) // Smooth transition
                                        .animation(.easeInOut, value: selectedCategory)
                                }
                            }
            .navigationTitle("Growth Hub")

//            .navigationBarHidden(true)
        }
        .tabItem {
            Image(systemName: "list.bullet")
            Text("Growth Hub")
        }
    }
}

struct GrowthHubView_Previews: PreviewProvider {
    static var previews: some View {
        GrowthHubView()
    }
}

// Preview
