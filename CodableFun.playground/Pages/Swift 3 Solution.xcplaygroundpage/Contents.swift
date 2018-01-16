/*:
 # Swift 3 Solution
 
 In Swift 3 we did most of this manually with some help from Foundation classes `JSONSerialization` and `PropertyListSerialization`. Here's a very simple example:
 
 First we'll create some information and encode it as raw JSON data.
 */
import Foundation

// Define information type.
struct Todo {
    let title: String
}

// Create instance.
let todo = Todo(
    title: "Find an easier way to encode/decode data"
)

// Create a dictionary representation of type `[String: Any]`.
let todoAsDictionary: [String: Any] = [
    "title": todo.title
]

// Encode as JSON data.
let encodedJSONData = try! JSONSerialization.data(
    withJSONObject: todoAsDictionary,
    options: []
)

// This is just to see the String representation of the encoded data.
String(data: encodedJSONData, encoding: .utf8)
/*:
 At this point we could save the data to disk or send it over the network to a webserver.
 
 Next we'll decode the raw JSON data back into and instance our Swift `Todo` type.
 */

// Decode raw JSON data back into Foundation object of the expected type, in this case `[String: Any]`. We need to know the JSON structure ahead of time in order to cast properly.
guard let decodedDictionary = try! JSONSerialization.jsonObject(
    with: encodedJSONData,
    options: []) as? [String: Any]
else {
    fatalError("Failed to decode raw JSON data back into [String: Any]")
}

// Make sure you can access each value as the corresponding type. This gets seriously tedious in real life because types usually have more than one property.
guard let title = decodedDictionary["title"] as? String else {
    fatalError("Failed to access String for key 'title' in decodedDictionary")
}

// Create instance from decoded dictionary values.
let decodedTodo = Todo(
    title: title
)

decodedTodo

/*:
 This works but it's a lot of boilerplate code, it's hard to read, and it's prone to errors due to use of `String` keys and `Any` types. The situation can be improved with generic helper functions, computed properties, and custom initializers, but then that will all need to be maintained too.
 
 So what makes Swift 4 better?
 */
//: [Next](@next)
