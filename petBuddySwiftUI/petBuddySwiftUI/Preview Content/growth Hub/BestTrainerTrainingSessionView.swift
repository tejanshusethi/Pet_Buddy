//
//  BestTrainerTrainingSessionView.swift
//  petBuddySwiftUI
//
//  Created by NITIN KALIRAMAN on 25/03/25.
//
import SwiftUI

struct BestTrainerTrainingSessionView: View {
    var session: TrainingSession
    
    var body: some View {
        VStack {
            // Header
            HStack {
                Image(session.trainingImage)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(session.trainingTitle)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text(session.trainingSubtitle)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding()
            
            // Exercises List
            List(session.exercises, id: \.exerciseID) { exercise in
                NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
                    HStack {
                        Image(exercise.image)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        VStack(alignment: .leading) {
                            Text(exercise.title)
                                .font(.headline)
                            
                            //                        ProgressView(value: exercise.progress)
                            //                            .progressViewStyle(LinearProgressViewStyle())
                            //                            .frame(height: 5)
                        }
                        
                        Spacer()
//                        Image(systemName: "chevron.right")
//                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 5)
                }
            }
            
            // Overall Progress Bar
            VStack {
                Text("Progress")
                    .font(.headline)
                    .padding(.top)
                
                ProgressView(value: session.progress)
                    .progressViewStyle(LinearProgressViewStyle())
                    .frame(height: 10)
                    .padding(.horizontal)
            }
            .padding(.bottom, 20)
        }
        .navigationTitle("Training Session")
        .toolbar(.hidden, for: .tabBar)
    }
}
