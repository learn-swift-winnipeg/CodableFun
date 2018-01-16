/*:
 # Swift 4's Codable
 
 The standard library in Swift 4 includes a collection of types/protocols to make encoding and decoding our custom Swift types relatively painless. It's simple, easy, powerful, and built-in. Personally I love it!
 
 Let's repeat the previous exercise but this time we'll use `Codable`:
 */
import Foundation

// Define information type conforming to `Codable`.
struct Todo: Codable {
    var title: String
}

// Create instance.
let todo = Todo(
    title: "Find something to do with all the time saved using Codable"
)

// Encode todo directly into JSON data, skipping the intermediary dictionary step.
guard let encodedJSONData = try? JSONEncoder().encode(todo) else {
    fatalError("Failed to encode todo")
}

// This is just to see the String representation of the encoded data.
String(data: encodedJSONData, encoding: .utf8)
/*:
 At this point we could save the data to disk or send it over the network to a webserver.
 
 Next we'll decode the raw JSON data back into and instance our Swift `Todo` type.
 */

// Decode raw JSON data directly back into a `Todo` instance, skipping the dictionary and value guard steps.
guard let decodedTodo = try? JSONDecoder().decode(Todo.self, from: encodedJSONData) else {
    fatalError("Failed to decode json data into Todo instance")
}

decodedTodo

/*:
 All the `String` keys, casting, conditional binding, is replaced by a single line of type safe code.
 
 When a type is defined as conforming to `Codable` the compiler will synthesize code needed to convert between the type and external representations such as JSON and property list, provided all property types also conform to `Codable`. This works for `title` in the example above because `String` already conforms to `Codable`.
 
 Ok great, but this is too easy. Let's look at a more complicated example.
 */
//: [Next](@next)
