/*:
 # UserDefaults
 
 We can also persist our Codable types to UserDefaults. We still have to convert to/from raw data but that can be simplified by extending UserDefaults with two generic functions.
 
 Let's look at some examples:
 */
import Foundation

// Define information type conforming to `Codable`.
struct Todo: Codable {
    let title: String
    let dueDate: Date
    
    enum Priority: String, Codable { case low, medium, high }
    let priority: Priority
}

// Create instance.
let todo = Todo(
    title: "Walk with Dexter in the valley",
    dueDate: Date(),
    priority: .high
)

// UserDefaults Access
let userDefaults = UserDefaults(suiteName: UUID().uuidString)!
let todoKey = "todoKey"

// Store in UserDefaults.
let encodedPropertyListData = try! PropertyListEncoder().encode(todo)
userDefaults.set(encodedPropertyListData, forKey: todoKey)

// Retrieve from UserDefaults.
let stillEncodedPropertyListData = userDefaults.data(forKey: todoKey)!
let decodedTodo = try! PropertyListDecoder().decode(Todo.self, from: stillEncodedPropertyListData)

decodedTodo

//: Simplify it even further by extending UserDefaults with two generic functions.
extension UserDefaults {
    func codableValue<T: Codable>(forKey key: String) throws -> T? {
        guard let encoded = self.value(forKey: key) as? Data else { return nil }
        return try PropertyListDecoder().decode(T.self, from: encoded)
    }
    
    func set<T: Codable>(codable value: T?, forKey key: String) throws {
        let encoded = try PropertyListEncoder().encode(value)
        self.set(encoded, forKey: key)
    }
}

// Store with generic helper
try! userDefaults.set(codable: todo, forKey: todoKey)

// Retrieve with generic helper
try! userDefaults.codableValue(forKey: todoKey) as Todo?

/*:
 Perfect! Is there anything else to know about Codable?
 */
//: [Next](@next)
