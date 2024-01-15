import Foundation

extension Calendar.Month.Raw: CustomStringConvertible {
    public var description: String {
        let header = header.joined(separator: " ")
        let date = "\(month) \(year.description)"
        let str = """
        \(date) \(locale.paddingLeft(toLength: header.count - date.count - 1, withPad: " ", startingAt: 0))
        \(timeZone.paddingLeft(toLength: header.count, withPad: " ", startingAt: 0))
        \(header)
        \(body.map { $0.map { $0.description.paddingLeft(toLength: 3, withPad: " ", startingAt: 0) }.joined(separator: " ") }.joined(separator: "\n"))
        """

        return str
    }
}
