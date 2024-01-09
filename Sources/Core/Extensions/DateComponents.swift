import Foundation

extension DateComponents {
    func weekday() -> Int? {
        guard let weekday = weekday else { return nil }
        guard let calendar = calendar else { return weekday }
        let moved = weekday + 1 - calendar.firstWeekday
        return moved > 0 ? moved : 7 + moved
    }
}
