import Algorithms
import Foundation

public extension Calendar.Month {
    struct Raw: Equatable, Codable, RawCalendar {
        var header: [String]
        var body: [[UInt8]]

        var year: Int
        var month: String
        var day: UInt8
        var weekday: String

        var date: String
        var locale: String
        var timeZone: String

        init(calendar: Calendar, date: Date, body: [[UInt8]]) {
            self.header = calendar.shortWeekdaySymbols
            self.header.rotate(toStartAt: calendar.firstWeekday - 1)
            self.body = body

            self.year = calendar.component(.year, from: date)
            self.month = calendar.monthSymbols[calendar.component(.month, from: date) - 1]
            self.day = .init(calendar.component(.day, from: date))
            self.weekday = calendar.weekdaySymbols[calendar.component(.weekday, from: date) - 1]

            self.date = date.description
            self.locale = (calendar.locale ?? .current).identifier
            self.timeZone = calendar.timeZone.identifier
        }
    }

    func raw(calendar: Calendar, day: UInt8 = 1, year: Int) -> Raw {
        let dateComps: DateComponents = .init(
            calendar: calendar,
            year: year,
            month: .init(rawValue),
            day: .init(day)
        )

        let date = calendar.date(from: dateComps)!
        let comps: Set<Calendar.Component> = [.day, .weekday, .month, .weekOfMonth, .calendar]
        var body: [[UInt8]] = .init(repeating: .init(repeating: 0, count: 7), count: 6)

        let firstWeekday = calendar.dateComponents(comps, from: date).weekday()!
        for day in 1 ..< firstWeekday {
            let date = date - .day(day)
            let comp = calendar.dateComponents(comps, from: date)
            let week = body.startIndex
            let weekday = comp.weekday()! - 1
            body[week][weekday] = .init(comp.day!)
        }

        let lastDay = calendar.range(of: .day, in: .month, for: date)!.upperBound - 1
        for day in 0 ..< lastDay {
            let date = date + .day(day)
            let comp = calendar.dateComponents(comps, from: date)
            let week = comp.weekOfMonth! - 1
            let weekday = comp.weekday()! - 1
            body[week][weekday] = .init(comp.day!)
        }

        let lastDayDate = date + .month(1) - .day(1)
        let lastComp = calendar.dateComponents(comps, from: lastDayDate)
        let weekday = lastComp.weekday()!
        let weekOfMonth = lastComp.weekOfMonth!
        for day in 1 ... 7 - weekday + 6 % weekOfMonth * 7 {
            let date = date + .month(1) + .day(day - 1)
            let comp = calendar.dateComponents(comps, from: date)
            let week = lastComp.weekOfMonth! + comp.weekOfMonth! - 2 + Int(weekday % 7 == 0)
            let weekday = comp.weekday()! - 1
            body[week][weekday] = .init(comp.day!)
        }

        return .init(calendar: calendar, date: date, body: body)
    }
}
