import XCTest
@testable import UDLoader

final class UDLoaderTests: XCTestCase {
    func testString() {
        let sema = DispatchSemaphore(value: 0)
        
        let task = "UDLoader".save(withKey: "name")
        
        task
            .whenFailure { _ in
            XCTFail()
        }
        
        task
            .whenSuccess {
                String.load(withKey: "name")
                    .whenSuccess { value in
                    XCTAssertEqual(value, "UDLoader")
                    sema.signal()
                }
        }
        
        sema.wait()
    }
    
    func testSimpleCodableObject() {
        let sema = DispatchSemaphore(value: 0)
        let object = SimpleCodableObject(string: "UDLoader", bool: false, int: 3)
        
        let task = object.save(withKey: "simple")
        
        task
            .whenFailure { _ in
            XCTFail()
        }
        
        task
            .whenSuccess {
                SimpleCodableObject.load(withKey: "simple")
                    .whenSuccess { value in
                    XCTAssertEqual(value, object)
                    sema.signal()
                }
        }
        
        sema.wait()
    }

    static var allTests = [
        ("testString", testString),
        ("testSimpleCodableObject", testSimpleCodableObject)
    ]
}

internal struct SimpleCodableObject: Codable, Equatable {
    let string: String
    let bool: Bool
    let int: Int
}
