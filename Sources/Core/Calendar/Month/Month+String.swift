import Foundation

extension Calendar.Month.Raw: CustomStringConvertible {
    public var description: String {
        """
        \(weekday), \(day.description) \(month) \(year.description)
        \(locale) \(timeZone)
        \(header.joined(separator: " "))
        \(body.map { $0.map { $0.description.paddingLeft(toLength: 3, withPad: " ", startingAt: 0) }.joined(separator: " ") }.joined(separator: "\n"))
        """
    }
}
