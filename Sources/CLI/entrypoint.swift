import ArgumentParser
import CGCore
import Foundation

extension RawCalendarResult: ExpressibleByArgument {
    public init?(argument: String) {
        self.init(rawValue: argument)
    }
}

extension Locale: ExpressibleByArgument {
    public init?(argument: String) {
        self.init(identifier: argument)
    }
}

extension TimeZone: ExpressibleByArgument {
    public init?(argument: String) {
        self.init(identifier: argument)
    }
}

@main
struct CG: ParsableCommand {
    var calendar: Calendar = .init(identifier: .gregorian)

    @Option(name: .shortAndLong)
    var type: RawCalendarResult?

    @Option(name: .shortAndLong)
    var locale: Locale?

    @Option(name: [.customShort("z"), .long])
    var timeZone: TimeZone?

    @Option(name: .shortAndLong)
    var year: Int?

    @Option(name: .shortAndLong)
    var month: String?

    @Option(name: .shortAndLong)
    var firstWeekday: String?

    mutating func validate() throws {
        calendar.locale = locale ?? .current
        calendar.timeZone = timeZone ?? .current

        if let firstWeekday = firstWeekday {
            if let firstWeekday = Int(firstWeekday) {
                guard firstWeekday >= 1, firstWeekday <= 7 else {
                    throw ValidationError("firstWeekday must be an integer between 1 and 7")
                }
                calendar.firstWeekday = firstWeekday
            } else {
                let firstWeekday = firstWeekday.lowercased()
                let index = [calendar.weekdaySymbols, calendar.shortWeekdaySymbols, calendar.veryShortWeekdaySymbols]
                    .map { $0.map { $0.lowercased() }}
                    .compactMap { $0.firstIndex(where: { $0.starts(with: firstWeekday) }) }
                    .first
                guard let index = index else {
                    throw ValidationError("firstWeekday must be a valid weekday")
                }
                calendar.firstWeekday = index + 1
            }
        }
    }

    func run() throws {
        guard let type = type else {
            throw ValidationError("cli output is not implemented yet")
        }

        let calendarMonth: Calendar.Month
        if let month = month {
            if let month = Int(month) {
                guard month >= 1, month <= 12 else {
                    throw ValidationError("month must be an integer between 1 and 12")
                }
                calendarMonth = .init(rawValue: month)!
            } else {
                let month = month.lowercased()
                let index = [calendar.monthSymbols, calendar.shortMonthSymbols, calendar.veryShortMonthSymbols]
                    .map { $0.map { $0.lowercased() }}
                    .compactMap { $0.firstIndex(where: { $0.starts(with: month) }) }
                    .first
                guard let index = index else {
                    throw ValidationError("month must be a valid month")
                }
                calendarMonth = .init(rawValue: index + 1)!
            }
        } else {
            calendarMonth = .init(rawValue: calendar.component(.month, from: Date()))!
        }
        let year = year ?? calendar.component(.year, from: Date())

        let raw = calendarMonth.raw(calendar: calendar, year: year)
        let output: String = switch type {
        case .raw: raw.description
        case .json: String(data: raw.json(), encoding: .utf8)!
        case .markdown: raw.markdown().format()
        case .html: raw.html().render()
        }

        print(output)
    }
}
