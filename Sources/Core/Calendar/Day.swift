import Foundation

public extension Calendar {
    enum Day: UInt8, CaseIterable {
        case sunday = 1
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday

        init?(rawValue: Int) {
            self.init(rawValue: UInt8(rawValue))
        }
    }
}
