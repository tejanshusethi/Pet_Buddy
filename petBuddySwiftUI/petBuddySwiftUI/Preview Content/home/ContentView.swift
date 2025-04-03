import SwiftUI





// Memories Card Component
// Memories Card Component (Full-Width)
struct MemoryCard: View {
    let imageName: String

    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity)
            .frame(height: 240) // Full width & fixed height
            .cornerRadius(12)
            .clipped()
            
            .padding(.horizontal)
    }
}

// Updated HomeView with Full-Width Memories Section
struct HomeView: View {
    @EnvironmentObject var reminderVM: ReminderViewModel
    @State private var trainingSessions = [
        trainingSession1,bestTrainerTrainingSession
    ]

    let memories = DataProvider.memories
        let careTips = DataProvider.careTips
    @State private var showProfile = false // State to track profile screen visibility

    @State private var currentReminder: Reminder?
    
        @State private var timer: Timer?
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Section Header
                    SectionHeader(title: "Memories")

                    // Horizontally Scrollable Memories Section
                    ScrollView(.horizontal, showsIndicators: false) {
                                            HStack {
                                                ForEach(memories.indices, id: \.self) { index in
                                                    Image(uiImage: memories[index].image ?? UIImage())
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: 350 )
                                                        .frame( height: 250)
                                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                                }
                                            }
                        .padding(.horizontal)
                    }

                    // Reminders Section
                    SectionHeader(title: "Reminders")
                    RemindersView()
             
                    
                                        
                    SectionHeader(title: "Care Tips")
              // Care Tips Section
                    ForEach(careTips.indices, id: \.self) { index in
                        let tip = careTips[index]
                        
                        NavigationLink(destination: CareTipDetailView(tip: tip)) {
                            HStack {
                                Image(uiImage: tip.careImage ?? UIImage())
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())

                                VStack(alignment: .leading) {
                                    Text(tip.careTitle)
                                        .font(.headline)
                                        .foregroundColor(.black) // Ensures text remains black
                                    
                                    Text(tip.careDescription)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                            }
//                            .padding()
                        }
                        .buttonStyle(PlainButtonStyle()) // Removes default blue NavigationLink styling
                        .background(Color.white) // Sets the background color to white
                        .cornerRadius(10)
                        
                        // Add Divider except for the last item
                        if index < careTips.count - 1 {
                            Divider()
                                .background(Color.gray.opacity(0.5)) // Light gray color for separator
                                .padding(.leading, 70) // Aligns with text (avoiding image overlap)
                        }
                    }


                                    
                                   

                    // Training Courses Section
                    SectionHeader(title: "Training Courses")
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(trainingSessions, id: \.trainingTitle) { session in
                                NavigationLink(destination: BestTrainerTrainingSessionView(session: session)) {
                                    TrainingCard(imageName: session.trainingImage, title: session.trainingTitle)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom, 50)
            }
            .navigationTitle("Home")
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button(action: {}) {
                            Image(systemName: "camera")
                        }
                        Button(action: {showProfile.toggle()}) {
                            Image(systemName: "person.circle")
                        }
                    }
                }
            }
            .fullScreenCover(isPresented: $showProfile) {
                            ProfileView()
                        }
        }
    }
}

// Section Header Component
struct SectionHeader: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.title2)
            .bold()
            .padding(.horizontal)
    }
}

// Reminder Card Component
import SwiftUI

struct RemindersView: View {
    @State private var currentReminder: Reminder?
    @State private var timer: Timer?

    let reminders = DataProvider.reminders


    var body: some View {
        VStack {
            if let reminder = currentReminder {
                VStack(alignment: .leading, spacing: 10) {
                    Text(reminder.reminderName)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.black)
                    
                    Text("Next: \(reminder.upcomingEvents)")
                        .font(.headline)
                        .foregroundColor(.black.opacity(0.8))

                    Text(reminder.reminderDescription)
                        .font(.body)
                        .foregroundColor(.black.opacity(0.7))
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(12)
                .padding(.horizontal)
            } else {
                Text("No upcoming reminders")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding()
            }
        }
        .onAppear {
            updateCurrentReminder()
            startTimer()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }

    // Function to update the current reminder
    private func updateCurrentReminder() {
        let currentTime = getCurrentTime()
        let sortedReminders = reminders.sorted { $0.upcomingEvents < $1.upcomingEvents }
        
        // Find the first reminder that is still upcoming
        currentReminder = sortedReminders.first { $0.upcomingEvents > currentTime }
    }

    // Timer to check reminders every minute
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
            updateCurrentReminder()
        }
    }

    // Helper function to get the current time in HH:mm AM/PM format
    private func getCurrentTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: Date())
    }
}


// Care Tips List Component
struct CareTip: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let tips: String
    let benefits: String
}


// Training Course Data Model
struct TrainingCourse {
    let image: String
    let title: String
}

// Sample Training Courses
let trainingCourses = [
    TrainingCourse(image: "dog_memory", title: "Basic Obedience Training"),
    TrainingCourse(image: "basic_commands", title: "Advanced Training"),
    TrainingCourse(image: "agilitytraining", title: "Agility Training"),
    TrainingCourse(image: "behavorialtraining", title: "Behavioral Training")
]

// Training Card Component (Horizontally Scrollable)
struct TrainingCard: View {
    let imageName: String
    let title: String

    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 140)
                .cornerRadius(12)
            
            Text(title)
                .font(.headline)
                .multilineTextAlignment(.center) // Center-align text
                .frame(width: 250, height: 40) // Fixed height for uniform alignment
                .padding(.top, 1)
        }
        .frame(width: 200, height: 180) // Ensures all cards have the same height
    }
}

// Tab Bar View
struct MainView: View {
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }

            NavigationStack {
                GrowthHubView()
            }
            .tabItem {
                Image(systemName: "list.bullet")
                Text("Growth Hub")
            }

            NavigationStack {
                CommunityView()
            }
            .tabItem {
                Image(systemName: "person.3.fill")
                Text("Community")
            }

            NavigationStack {
                Vetset()
            }
            .tabItem {
                Image(systemName: "stethoscope")
                Text("VetSet")
            }
        }
    }
}



// Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
