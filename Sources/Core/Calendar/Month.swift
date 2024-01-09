import Foundation

enum Month: Int, CaseIterable {
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
}

extension Month {
    func raw(calendar: Calendar, year: Int) -> [[String]] {
        let dateComps = DateComponents(
            calendar: calendar,
            year: year,
            month: rawValue,
            day: 1
        )

        let date = calendar.date(from: dateComps)!

        var raw = Array(repeating: Array(repeating: "", count: 7), count: 7)
        raw[0] = calendar.shortWeekdaySymbols

        let comps: Set<Calendar.Component> = [.day, .weekday, .month, .weekOfMonth, .calendar]

        let firstWeekday = calendar.dateComponents(comps, from: date).weekday()!
        for day in 1 ..< firstWeekday {
            let date = date - .day(day)
            let comp = calendar.dateComponents(comps, from: date)
            let week = raw.startIndex + 1
            let weekday = comp.weekday()! - 1
            raw[week][weekday] = comp.day!.description
        }

        let lastDay = calendar.range(of: .day, in: .month, for: date)!.upperBound - 1
        for day in 0 ..< lastDay {
            let date = date + .day(day)
            let comp = calendar.dateComponents(comps, from: date)
            let week = comp.weekOfMonth!
            let weekday = comp.weekday()! - 1
            raw[week][weekday] = comp.day!.description
        }

        let lastDayDate = date + .month(1) - .day(1)
        let lastComp = calendar.dateComponents(comps, from: lastDayDate)
        let weekday = lastComp.weekday()!
        let weekOfMonth = lastComp.weekOfMonth!
        for day in 1 ... 7 - weekday + 6 % weekOfMonth * 7 {
            let date = date + .month(1) + .day(day - 1)
            let comp = calendar.dateComponents(comps, from: date)
            let week = lastComp.weekOfMonth! + comp.weekOfMonth! - 1 + Int(weekday % 7 == 0)
            let weekday = comp.weekday()! - 1
            raw[week][weekday] = comp.day!.description
        }

        return raw
    }
}
