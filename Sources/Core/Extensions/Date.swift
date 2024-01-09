import Foundation

extension Date {
    enum Component {
        case year(Int)
        case month(Int)
        case day(Int)

        static prefix func -(rhs: Self) -> Self {
            switch rhs {
            case .year(let value): .year(-value)
            case .month(let value): .month(-value)
            case .day(let value): .day(-value)
            }
        }
    }

    static func +(lhs: Self, rhs: Component) -> Self {
        switch rhs {
        case .year(let value): Calendar.current.date(byAdding: .year, value: value, to: lhs)!
        case .month(let value): Calendar.current.date(byAdding: .month, value: value, to: lhs)!
        case .day(let value): Calendar.current.date(byAdding: .day, value: value, to: lhs)!
        }
    }

    static func -(lhs: Self, rhs: Component) -> Self {
        lhs + -rhs
    }
}
