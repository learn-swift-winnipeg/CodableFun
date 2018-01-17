/*:
 # What problem are we trying to solve?
 
 Our apps have pieces of user's information in them. We tend to refer to this information as "data" or "model objects". In a Todo app this may be a single `Todo` item.
 
 This information is created, modified, deleted, passed around, saved to disk, loaded from disk, sent to the internet, retrieved from the internet, etc.
 
 Inside our apps we will almost certainly represent this information as custom Swift type such as `struct`, `enum`, and/or `class`. This works great as long as we stay in Swift land.
 
 The **problem** is we can't stay in Swift land forever, at least not yet. At some point we will need to save this information to/from disk or transfer over a network and, as of today, filesystems and networks don't speak Swift.
 
 The **solution** is to "serialize" the information into raw binary data (0s and 1s) before we send it somewhere, and then "de-serialize" it back into Swift types when we retrieve it.
 
 So how did we accomplish this in Swift 3?
 */
//: [Next](@next)
