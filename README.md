# UDLoader

[UserDefaults](https://developer.apple.com/documentation/foundation/userdefaults) & [Later](https://github.com/0xLeif/Later)

## Example

```swift
// Save Codable Value
SimpleCodableObject(string: "UDLoader", bool: false, int: 3).save(withKey: "simple")

// Load Codable Value
SimpleCodableObject.load(withKey: "simple")
    .whenSuccess { value in
    // ...
}
```
