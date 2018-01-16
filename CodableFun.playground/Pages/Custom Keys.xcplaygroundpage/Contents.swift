/*:
 # Custom Keys
 
 When the webserver returns JSON with crazy non-Swifty keys like `TITLE` or `due_date` we can use a special nested enum called `CodingKeys` to map our Swifty-named properties to the crazy JSON keys. Yes!
 
 Let's repeat the previous exercise this time using JSON with non-swifty key names:
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
    
    // Define custom key names by declaring a special nested enum called `CodingKeys` with a case matching each property name and a raw value of the custom key.
    enum CodingKeys: String, CodingKey {
        case title = "TITLE"
        case dueDate = "due_date"
        case priority // The default raw-representable value of `priority` is fine here.
    }
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
 Great! What's next?
 
 Let's look at some common JSON structures webservices use.
 */
//: [Next](@next)
