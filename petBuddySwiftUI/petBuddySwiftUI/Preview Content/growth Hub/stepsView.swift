// ExerciseDetailView.swift
import SwiftUI

struct ExerciseDetailView: View {
    var exercise: Exercise
    @State private var completedSteps: Set<String> = [] // Track completed steps by their title
    
    var body: some View {
        VStack(alignment: .leading) {
            // Title
            Text(exercise.title)
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            // Subtitle
            Text("Training the \(exercise.title)")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.horizontal)
            
            // Steps List
            List(exercise.steps, id: \.title) { step in
                HStack {
                    Image(step.stepInfo.stepImage)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Text(step.title)
                        .font(.headline)
                        .lineLimit(2)
                    
                    Spacer()
                    
                    if completedSteps.contains(step.title) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                    } else {
                        // Show NavigationLink only when the step is not completed
                        NavigationLink("", destination: StepInfoView(step: step, isCompleted: Binding(
                            get: { completedSteps.contains(step.title) },
                            set: { if $0 { completedSteps.insert(step.title) } else { completedSteps.remove(step.title) } }
                        )))
                        .frame(width: 10) // Reduce its frame so it doesn't take up much space
                    }
                }
                .padding(.vertical, 5)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding(.top, 10)
    }
}
