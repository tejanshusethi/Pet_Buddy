import SwiftUI

struct Pet: Identifiable {
    let id = UUID()
    let name: String
    let breed: String
    let age: String
    let gender: String
    let size: String
    let hobby: String
    let image: UIImage?
}
extension Pet {
    static var mockPet: Pet {
        Pet(name: "Buddy", breed: "Golden Retriever", age: "3", gender: "Male", size: "Large", hobby: "Fetching", image: nil)
    }
}
