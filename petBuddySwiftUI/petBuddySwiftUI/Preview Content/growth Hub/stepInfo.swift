import SwiftUI
import AVKit
struct StepInfoView: View {
    var step: Step
    @Binding var isCompleted: Bool
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Main Image
                Image(step.stepInfo.stepImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)

                // Steps & Tips Section
                Text("Steps & Tips")
                    .font(.title2).bold()
                    .padding(.horizontal)
                
                VStack {
                    ForEach(step.stepInfo.tips, id: \.self) { step in
                        Text(step)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .padding(.horizontal)
                    }
                }

                // Videos & Tutorials Section
                Text("Videos & Tutorials")
                    .font(.title2).bold()
                    .padding(.horizontal)
                
                if let videoURL = step.stepInfo.videos {
                    VideoPlayer(player: AVPlayer(url: videoURL))
                        .frame(height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.horizontal)
                } else {
                    Text("No video available")
                        .foregroundColor(.gray)
                        .frame(height: 250)
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray5))
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
            }
        }
        .navigationTitle("Training Tutorial")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Done") {
                    isCompleted = true
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}
