//
//  growthData.swift
//  petBuddySwiftUI
//

//

import Foundation
import SwiftUI

struct TrainingImage{
    let trainingImages: UIImage!
}
struct Tips{
    let tipLabel: String
}
struct TipVideo {
    let tipVideo: String        // Video description
    let videoURL: URL           // URL for the video
    let thumbnailImage: UIImage // Thumbnail image for the video
}

struct trainingExercise{
    let exerciseName: String
    let exerciseImage: UIImage!
    
}
struct StepInfo {
    var stepImage: String
    var thumbnailImage : String// Image representing the step
    var tips: [String]        // Array of tips related to the step
    var videos: URL?       // Array of video URLs related to the step
}

// Step: Represents a single step in an exercise
struct Step {
//    var stepID: String        // Unique ID for each step
    var title: String         // Title of the step
    var stepInfo: StepInfo    // Step-specific information (image, tips, videos)
    var progress: Float       // Track completion progress for each step (0.0 - 1.0)
}

// Exercise: Represents an individual exercise with steps
struct Exercise {
    var exerciseID: String       // Unique ID for the exercise
    var title: String            // Title of the exercise
    var image: String        // Image representing the exercise
    var steps: [Step]            // List of steps for the exercise
    var progress: Float          // Track the progress of the exercise (0.0 - 1.0)
}

// TrainingSession: Represents a full training session, which includes multiple exercises
struct TrainingSession {
    var trainingImage: String
    var trainingTitle: String    // Main title of the training session
    var trainingSubtitle: String// Subtitle for the training session
    var progress: Float          // Overall progress of the training session (0.0 - 1.0)
    var exercises: [Exercise]    // List of exercises in the training session
}

// Combined WorkoutPlan structure to hold all other structures as arrays
struct WorkoutPlan {
       // Array of Exercise instances
    var trainingSessions: TrainingSession // Array of TrainingSession instances
}


let exampleImage = "sit"

// Example video URL
let exampleVideoURL = URL(string: "https://example.com/training-video")!
let stepInfo1 = StepInfo(
    stepImage: exampleImage, thumbnailImage: exampleImage,
    tips: ["Keep sessions short to avoid frustration", "Always reward the dog when they sit to reinforce the behavior","Be patient and consistent with the command and rewards"
],
    videos: exampleVideoURL
)

let stepInfo2 = StepInfo(
    stepImage: exampleImage, thumbnailImage: exampleImage,
    tips: ["Keep sessions short to avid frustration", "Always reward the dog when they sit to reinforce the behavior","Be patient and consistent with the command and rewards"],
    videos: exampleVideoURL
)
let stepInfo3 = StepInfo(
    stepImage: exampleImage, thumbnailImage: exampleImage,
    tips: ["Keep sessions short to avoid frustration", "Always reward the dog when they sit to reinforce the behavior","Be patient and consistent with the command and rewards"],
    videos: exampleVideoURL
)
let stepInfo4 = StepInfo(
    stepImage: exampleImage, thumbnailImage: exampleImage,
    tips: ["Start in a quiet space with few distractions", "Increase distance and duration in small increments to avoid confusion","Use a calm tone when giving the command and rewarding"],
    videos: exampleVideoURL
)
let stepInfo5 = StepInfo(
    stepImage: exampleImage, thumbnailImage: exampleImage,
    tips: ["Use a high-pitched, exciting voice to make the Come", "Never punish your dog if they take a long time to come"," Always reward them immediately when they come to you"],
    videos: exampleVideoURL
)
// Steps for Dog Training
let command1Step1 = Step(
    title: "Hold a treat above your dog’s nose",
    stepInfo: stepInfo1,
    progress: 0.5
)

let command1Step2 = Step(
    title: "Move your hand upward, allowing your dog’s head to follow the treat",
    stepInfo: stepInfo2,
    progress: 0.3
)
let command1Step3 = Step(
    title: "As soon as your dog’s bottom hits the ground, say “Sit” and give them the treat. ",
    stepInfo: stepInfo3,
    progress: 0.3
)
let command2Step1 = Step(
    title: "Begin with your dog in the sitting position.",
    stepInfo: stepInfo4,
    progress: 0.3
)

let command2Step2 = Step(
    title: "Hold your palm in front of their face and say Stay.",
    stepInfo: stepInfo4,
    progress: 0.3
)
let command2Step3 = Step(
    title: "Take a small step backward. If your dog stays, return and reward them",
    stepInfo: stepInfo4,
    progress: 0.3
)
let command2Step4 = Step(
    title: "Gradually increase the duration and distance.",
    stepInfo: stepInfo4,
    progress: 0.3
)
let command2Step5 = Step(
    title: "Release them with the word “Okay” or another cue.",
    stepInfo: stepInfo4,
    progress: 0.3
)
let command3Step1 = Step(
    title: "Start in a quiet room or space with few distractions",
    stepInfo: stepInfo5,
    progress: 0.3
)
let command3Step2 = Step(
    title: " Call your dog’s name, followed by Come.",
    stepInfo: stepInfo5,
    progress: 0.3
)
let command3Step3 = Step(
    title: "When your dog approaches, reward them with praise and treats.",
    stepInfo: stepInfo5,
    progress: 0.3
)
let command3Step4 = Step(
    title: "Repeat several times, gradually increasing the distance between you and your dog.",
    stepInfo: stepInfo5,
    progress: 0.3
)
// Exercises for Dog Training
let command1 = Exercise(
    exerciseID: "exercise1.1",
    title: " Sit Command",
    image: exampleImage,
    steps: [command1Step1,command1Step2,command1Step3],
    progress: 0.4
)
let command4step1 = Step(
    title: "Introduce the Command",
    stepInfo: StepInfo(
        stepImage: "shake_hand_step1.png",
        thumbnailImage: "shake_hand_thumb1.png",
        tips: [
            "Hold a treat in your hand to get your pet's attention.",
            "Gently lift their paw while saying 'Shake Hand'."
        ],
        videos: URL(string: "https://example.com/shake_hand_step1.mp4")!
    ),
    progress: 0.3
)

let command4step2 = Step(
    title: "Reward and Repeat",
    stepInfo: StepInfo(
        stepImage: "shake_hand_step2.png",
        thumbnailImage: "shake_hand_thumb2.png",
        tips: [
            "Give a treat immediately after they lift their paw.",
            "Repeat the process until they lift their paw on their own."
        ],
        videos: URL(string: "https://example.com/shake_hand_step2.mp4")!
    ),
    progress: 0.6
)
let command5step1 = Step(
    title: "Start with a Lie Down",
    stepInfo: StepInfo(
        stepImage: "roll_over_step1.png",
        thumbnailImage: "roll_over_thumb1.png",
        tips: [
            "Make sure your pet is in a comfortable position lying down.",
            "Use a treat to guide their head towards their shoulder."
        ],
        videos: URL(string: "https://example.com/roll_over_step1.mp4")!
    ),
    progress: 0.3
)

let command5step2 = Step(
    title: "Complete the Roll",
    stepInfo: StepInfo(
        stepImage: "roll_over_step2.png",
        thumbnailImage: "roll_over_thumb2.png",
        tips: [
            "Move the treat further to encourage a full roll.",
            "Reward immediately when they complete the roll."
        ],
        videos: URL(string: "https://example.com/roll_over_step2.mp4")!
    ),
    progress: 0.6
)

let command2 = Exercise(
    exerciseID: "exercise1.2",
    title: "Stay Command",
    image: exampleImage,
    steps: [command2Step1,command2Step2,command2Step3,command2Step4,command2Step5],
    progress: 0.6
)
let command3 = Exercise(
    exerciseID: "exercise1.3",
    title: "Come Command",
    image: exampleImage,
    steps: [command3Step1,command3Step2,command3Step3,command3Step4],
    progress: 0.6
)
let command4 = Exercise(
    exerciseID: "exercise1.4",
    title: "Shake Hand",
    image: exampleImage,
    steps: [command4step1,command4step2],
    progress: 0.6
)
let command5 = Exercise(
    exerciseID: "exercise1.5",
    title: "Roll Over",
    image: exampleImage,
    steps: [command5step1,command5step2],
    progress: 0.6
)
// Training Session Data
let trainingSession1 = TrainingSession(
    trainingImage: "basic_commands",
    trainingTitle: "Basic Obedience Training",
    trainingSubtitle: "Morning sessions for obedience training",
    progress: 0.5,
    
    exercises: [command1, command2,command3,command4,command5]
)

let exampleImageName = "exampleImage"  // Example image name (use actual image name from assets)
let exampleVideoURL1 = URL(string: "https://example.com/training-video")!

// Create steps for the "Best Trainer Course"
let BestTrainerExercise1Step1 = Step(
    title: "Basic Obedience",
    stepInfo: StepInfo(
        stepImage: exampleImageName, thumbnailImage: exampleImage,  // Image name instead of UIImage object
        tips: ["Stay calm and consistent.", "Use positive reinforcement."],
        videos: exampleVideoURL1
    ),
    progress: 0.5
)

let BestTrainerExercise1Step2 = Step(
    title: "Advanced Tricks",
    stepInfo: StepInfo(
        stepImage: exampleImageName, thumbnailImage: exampleImage,  // Image name instead of UIImage object
        tips: ["Gradually increase difficulty.", "Use clickers for more precision."],
        videos: exampleVideoURL1
    ),
    progress: 0.3
)

let BestTrainerExercise2Step1 = Step(
    title: "Leash Walking",
    stepInfo: StepInfo(
        stepImage: exampleImageName, thumbnailImage: exampleImage,  // Image name instead of UIImage object
        tips: ["Start with short distances.", "Reward calm behavior."],
        videos: exampleVideoURL1
    ),
    progress: 0.4
)

// Create exercises for the "Best Trainer Course"
let BestTrainerExercise1 = Exercise(
    exerciseID: "exercise2.1",
    title: "Obedience Training",
    image: exampleImageName,  // Image name instead of UIImage object
    steps: [ BestTrainerExercise1Step1,BestTrainerExercise1Step1],
    progress: 0.6
)

let BestTrainerExercise2 = Exercise(
    exerciseID: "exercise2.2",
    title: "Leash Walking",
    image: exampleImageName,  // Image name instead of UIImage object
    steps: [BestTrainerExercise2Step1],
    progress: 0.7
)

// Create the "Best Trainer Course" training session
let bestTrainerTrainingSession = TrainingSession(
    trainingImage: "trainer_course_icon", trainingTitle: "Best Trainer Course",
    trainingSubtitle: "Advanced obedience and trick training",
    progress: 0.5,  // overall progress of the course
    exercises: [BestTrainerExercise1, BestTrainerExercise2]
)

// Create the WorkoutPlan for the "Best Trainer Course"
let step1 = Step(
    title: "Lure Dog into Sit Position",
    stepInfo: StepInfo(
        stepImage: "step1_sit",
        thumbnailImage: "step1_thumbnail",
        tips: ["Use a treat to lure your dog's nose up", "Slowly move the treat back over their head"],
        videos: URL(string: "https://example.com/sit-command.mp4")
    ),
    progress: 0.0
)

let step2 = Step(
    title: "Stay Command Basics",
    stepInfo: StepInfo(
        stepImage: "step2_stay",
        thumbnailImage: "step2_thumbnail",
        tips: ["Start with your dog in a sitting position", "Hold your palm out and say 'Stay'"],
        videos: URL(string: "https://example.com/stay-command.mp4")
    ),
    progress: 0.0
)

let step3 = Step(
    title: "Encouraging the Come Command",
    stepInfo: StepInfo(
        stepImage: "step3_come",
        thumbnailImage: "step3_thumbnail",
        tips: ["Use an excited tone to call your dog", "Reward them when they reach you"],
        videos: URL(string: "https://example.com/come-command.mp4")
    ),
    progress: 0.0
)

// Exercises with Steps
let sitExercise = Exercise(
    exerciseID: "E1",
    title: "Sit Command",
    image: "sit_command",
    steps: [step1],
    progress: 0.0
)

let stayExercise = Exercise(
    exerciseID: "E2",
    title: "Stay Command",
    image: "stay_command",
    steps: [step2],
    progress: 0.0
)

let comeExercise = Exercise(
    exerciseID: "E3",
    title: "Come Command",
    image: "come_command",
    steps: [step3],
    progress: 0.0
)

let trainingExercisesWithSteps = [sitExercise, stayExercise, comeExercise]

let newDogTrainingSession = TrainingSession(
    trainingImage: "new_dog_training",
    trainingTitle: "New Dog Training",
    trainingSubtitle: "Essential commands to train your new dog",
    progress: 0.0,
    exercises: trainingExercisesWithSteps
)
