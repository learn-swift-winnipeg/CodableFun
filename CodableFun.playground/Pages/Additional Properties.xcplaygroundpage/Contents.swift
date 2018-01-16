/*:
 # Additional Properties
 
 Let's repeat the previous exercise but with a more complicated type:
 */
import Foundation

// Define information type conforming to `Codable`.
struct Todo: Codable {
    
    // Standard Library types
    let title: String
    let dueDate: Date
    
    // Custom type conforming to Codable. Experiment with remove Codable conformance here.
    enum Priority: String, Codable {
        case low, medium, high
    }
    let priority: Priority
}

// Create instance.
let todo = Todo(
    title: "Walk with Dexter in the valley",
    dueDate: Date(),
    priority: .high
)

// Encode as JSON data.
let encodedJSONData = try! JSONEncoder().encode(todo)

// This is just to see the String representation of the encoded data.
String(data: encodedJSONData, encoding: .utf8)

// Decode raw JSON data directly back into a `Todo` instance.
let decodedTodo = try! JSONDecoder().decode(Todo.self, from: encodedJSONData)

decodedTodo

/*:
 Note encoding and decoding still only require a single line of type safe code. We could add 1000 properties and they would still only take a single line of code. That's great!
 
 But what if the webserver returns JSON with crazy non-Swifty keys like `TITLE` or `due_date`?
 */
//: [Next](@next)
