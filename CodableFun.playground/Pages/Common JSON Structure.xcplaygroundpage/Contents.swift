/*:
 # Common JSON Structures
 
 Webservices can structure their JSON in any number ways. Here are some common structures:
 
 - Root level wrapper object: `{ "todos": [{...}] }`
 - Root level array: `[{...}]`
 - Root level array of wrapper objects: `[{ "todo": {...} }]`
 
 We *could* fall back on `JSONSerialization`, conditional binding, and casting to `Array` and `Dictionary`, but there is a much simpler solution which was not immediately obvious to me... use `Codable` types to model these structures in Swift.
 
 Let's look at a few examples:
 */
import Foundation

// Define information type conforming to `Codable`.
struct Todo: Codable {
    let title: String
    let dueDate: Date
    
    enum Priority: String, Codable { case low, medium, high }
    let priority: Priority
}

// Create Todo JSON used in all the examples.
let todoJSONString = """
    {
        "title": "Walk with Dexter in the valley",
        "dueDate":537909750.97187901,
        "priority":"high"
    }
"""
//: Root level wrapper object
// Create JSON data with a root level wrapper object.
let rootLevelwrapperObjectJSONData = """
    {
        "todos": [
            \(todoJSONString),
            \(todoJSONString)
        ]
    }
""".data(using: .utf8)!

// Define new Codable type to model this structure.
struct RootLevelWrappedTodos: Codable {
    let todos: [Todo]
}

// Decode raw JSON data into `RootLevelWrappedTodos` instance.
let decodedRootLevelWrappedTodos = try! JSONDecoder().decode(RootLevelWrappedTodos.self, from: rootLevelwrapperObjectJSONData)

decodedRootLevelWrappedTodos.todos

//: Root level array
// Create JSON data with a root level array.
let rootLevelArrayJSONData = """
    [
        \(todoJSONString),
        \(todoJSONString)
    ]
""".data(using: .utf8)!

// Decode raw JSON data into Array<Todo> instance. This is possible becuase Array<T> is already `Codable` provided `T` is `Codable`. Cool!
let decodedRootLevelArrayTodos = try! JSONDecoder().decode(Array<Todo>.self, from: rootLevelArrayJSONData)

//: Root level array of wrapper objects
// Create JSON data with a root level array of wrapper objects
let rootLevelArrayOfWrapperObjectsJSONData = """
    [
        { "todo": \(todoJSONString) },
        { "todo": \(todoJSONString) },
    ]
""".data(using: .utf8)!

// Define new Codable type to model the wrapper objects.
struct WrappedTodo: Codable {
    let todo: Todo
}

// Decode raw JSON data into Array<WrappedTodo> instance.
let decodedRootLevelArrayOfWrapperObjects = try! JSONDecoder().decode(Array<WrappedTodo>.self, from: rootLevelArrayOfWrapperObjectsJSONData)

let unwrappedTodos = decodedRootLevelArrayOfWrapperObjects.flatMap({ $0.todo })

unwrappedTodos
/*:
 This all very good but I'm sick of JSON, I want to know about UserDefaults!!!
 */
//: [Next](@next)
