import Foundation

public extension Calendar {
    enum Month: UInt8, CaseIterable {
        case january = 1
        case february
        case march
        case april
        case may
        case june
        case july
        case august
        case september
        case october
        case november
        case december

        public init?(rawValue: Int) {
            self.init(rawValue: UInt8(rawValue))
        }
    }
}
