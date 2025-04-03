//
//  startTrainingSessionView.swift
//  petBuddySwiftUI
//
import SwiftUI

struct TrainingSessionView: View {
    var session: TrainingSession
        @Binding var trainingSessions: [TrainingSession]
        @Binding var exploreCourses: [TrainingSession]
    @Environment(\.presentationMode) var presentationMode  // To navigate back

    
    var body: some View {
        NavigationStack {
            VStack {
                // Title and Subtitle
                VStack(alignment: .leading, spacing: 5) {
                    Text("Training Session")
                        .font(.largeTitle)
                        .bold()
                    
                    Text(session.trainingTitle)
                        .font(.title2)
                        .bold()
                    
                    Text(session.trainingSubtitle)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top)
                
                // Command List
                List(session.exercises, id: \.exerciseID) { exercise in

                        Text(exercise.title)
                            .font(.headline)

                }
                .listStyle(InsetGroupedListStyle())
                
                // Start Button
                Button(action: {
                    startTraining()
                }) {
                    Text("Start")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding(.bottom, 20) // Adjust bottom padding
            }
            .navigationTitle("Growth Hub")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .tabBar)
        }
        
    }
    private func startTraining() {
           if let index = exploreCourses.firstIndex(where: { $0.trainingTitle == session.trainingTitle }) {
               trainingSessions.append(session) // Move to ongoing courses
               exploreCourses.remove(at: index) // Remove from explore courses
           }
        presentationMode.wrappedValue.dismiss()
       }
}

//struct TrainingSessionView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrainingSessionView()
//    }
//}

