import Foundation
import Later

public enum UDLoaderError: Error {
    case nilValue
}

public extension Encodable {
    @discardableResult
    func save(withKey key: String) -> LaterValue<Void> {
        Later.promise { promise in
            do {
                UserDefaults.standard.set(try JSONEncoder().encode(self), forKey: key)
            } catch {
                promise.fail(error)
            }
            promise.succeed(())
        }
    }
}

public extension Decodable {
    @discardableResult
    static func load(withKey key: String) -> LaterValue<Self> {
        Later.promise { promise in
            guard let data = UserDefaults.standard.data(forKey: key) else {
                promise.fail(UDLoaderError.nilValue)
                return
            }
            do {
                promise.succeed(try JSONDecoder().decode(Self.self, from: data))
            } catch {
                promise.fail(error)
            }
        }
    }
}
