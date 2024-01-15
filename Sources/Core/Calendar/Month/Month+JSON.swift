import Foundation

public extension Calendar.Month.Raw {
    func json() -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        return try! encoder.encode(self)
    }
}
