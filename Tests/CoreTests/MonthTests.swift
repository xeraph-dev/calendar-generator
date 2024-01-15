@testable import CGCore
import Foundation
import XCTest

class MonthTests: XCTestCase {
    var calendar: Calendar {
        var calendar: Calendar = .init(identifier: .gregorian)
        calendar.firstWeekday = .init(Day.sunday.rawValue)
        calendar.timeZone = .init(identifier: "America/Havana")!
        calendar.locale = .init(identifier: "en_US")
        return calendar
    }

    let year = 2024
    let day: UInt8 = 1

    var dateComps: DateComponents {
        .init(
            calendar: calendar,
            year: year,
            day: Int(day)
        )
    }

    func testRaw() {
        let day: UInt8 = 10
        let body: [[UInt8]] = [[1, 2, 3], [4, 5, 6]]
        var dateComps = dateComps
        dateComps.day = .init(day)
        dateComps.month = .init(Calendar.Month.january.rawValue)
        let date = calendar.date(from: dateComps)!
        let raw = Calendar.Month.Raw(calendar: calendar, date: date, body: body)
        XCTAssertEqual(raw.header, calendar.shortWeekdaySymbols)
        XCTAssertEqual(raw.body, body)
        XCTAssertEqual(raw.year, year)
        XCTAssertEqual(raw.month, calendar.monthSymbols[0])
        XCTAssertEqual(raw.day, day)
        XCTAssertEqual(raw.weekday, calendar.weekdaySymbols[3])
        XCTAssertEqual(raw.date, date.description)
        XCTAssertEqual(raw.locale, calendar.locale!.identifier)
        XCTAssertEqual(raw.timeZone, calendar.timeZone.identifier)
    }

    func testRawJanuary() {
        var dateComps = dateComps
        dateComps.month = .init(Calendar.Month.january.rawValue)
        let date = calendar.date(from: dateComps)!
        XCTAssertEqual(
            Calendar.Month.january.raw(calendar: calendar, day: day, year: year),
            .init(calendar: calendar, date: date, body: ([31] + (1...31) + (1...10)).chunks(7))
        )
    }

    func testRawFebruary() {
        var dateComps = dateComps
        dateComps.month = .init(Calendar.Month.february.rawValue)
        let date = calendar.date(from: dateComps)!
        XCTAssertEqual(
            Calendar.Month.february.raw(calendar: calendar, day: day, year: year),
            .init(calendar: calendar, date: date, body: ([] + (28...31) + (1...29) + (1...9)).chunks(7))
        )
    }

    func testRawMarch() {
        var dateComps = dateComps
        dateComps.month = .init(Calendar.Month.march.rawValue)
        let date = calendar.date(from: dateComps)!
        XCTAssertEqual(
            Calendar.Month.march.raw(calendar: calendar, day: day, year: year),
            .init(calendar: calendar, date: date, body: ([] + (25...29) + (1...31) + (1...6)).chunks(7))
        )
    }

    func testRawApril() {
        var dateComps = dateComps
        dateComps.month = .init(Calendar.Month.april.rawValue)
        let date = calendar.date(from: dateComps)!
        XCTAssertEqual(
            Calendar.Month.april.raw(calendar: calendar, day: day, year: year),
            .init(calendar: calendar, date: date, body: ([31] + (1...30) + (1...11)).chunks(7))
        )
    }

    func testRawMay() {
        var dateComps = dateComps
        dateComps.month = .init(Calendar.Month.may.rawValue)
        let date = calendar.date(from: dateComps)!
        XCTAssertEqual(
            Calendar.Month.may.raw(calendar: calendar, day: day, year: year),
            .init(calendar: calendar, date: date, body: ([] + (28...30) + (1...31) + (1...8)).chunks(7))
        )
    }

    func testRawJune() {
        var dateComps = dateComps
        dateComps.month = .init(Calendar.Month.june.rawValue)
        let date = calendar.date(from: dateComps)!
        XCTAssertEqual(
            Calendar.Month.june.raw(calendar: calendar, day: day, year: year),
            .init(calendar: calendar, date: date, body: ([] + (26...31) + (1...30) + (1...6)).chunks(7))
        )
    }

    func testRawJuly() {
        var dateComps = dateComps
        dateComps.month = .init(Calendar.Month.july.rawValue)
        let date = calendar.date(from: dateComps)!
        XCTAssertEqual(
            Calendar.Month.july.raw(calendar: calendar, day: day, year: year),
            .init(calendar: calendar, date: date, body: ([30] + (1...31) + (1...10)).chunks(7))
        )
    }

    func testRawAugust() {
        var dateComps = dateComps
        dateComps.month = .init(Calendar.Month.august.rawValue)
        let date = calendar.date(from: dateComps)!
        XCTAssertEqual(
            Calendar.Month.august.raw(calendar: calendar, day: day, year: year),
            .init(calendar: calendar, date: date, body: ([] + (28...31) + (1...31) + (1...7)).chunks(7))
        )
    }

    func testRawSeptember() {
        var dateComps = dateComps
        dateComps.month = .init(Calendar.Month.september.rawValue)
        let date = calendar.date(from: dateComps)!
        XCTAssertEqual(
            Calendar.Month.september.raw(calendar: calendar, day: day, year: year),
            .init(calendar: calendar, date: date, body: ([] + (1...30) + (1...12)).chunks(7))
        )
    }

    func testRawOctober() {
        var dateComps = dateComps
        dateComps.month = .init(Calendar.Month.october.rawValue)
        let date = calendar.date(from: dateComps)!
        XCTAssertEqual(
            Calendar.Month.october.raw(calendar: calendar, day: day, year: year),
            .init(calendar: calendar, date: date, body: ([] + (29...30) + (1...31) + (1...9)).chunks(7))
        )
    }

    func testRawNovember() {
        var dateComps = dateComps
        dateComps.month = .init(Calendar.Month.november.rawValue)
        let date = calendar.date(from: dateComps)!
        XCTAssertEqual(
            Calendar.Month.november.raw(calendar: calendar, day: day, year: year),
            .init(calendar: calendar, date: date, body: ([] + (27...31) + (1...30) + (1...7)).chunks(7))
        )
    }

    func testRawDecember() {
        var dateComps = dateComps
        dateComps.month = .init(Calendar.Month.december.rawValue)
        let date = calendar.date(from: dateComps)!
        XCTAssertEqual(
            Calendar.Month.december.raw(calendar: calendar, day: day, year: year),
            .init(calendar: calendar, date: date, body: ([] + (1...31) + (1...11)).chunks(7))
        )
    }

    func testRawJanuary2025() {
        var dateComps = dateComps
        dateComps.month = .init(Calendar.Month.january.rawValue)
        dateComps.year = 2025
        let date = calendar.date(from: dateComps)!
        XCTAssertEqual(
            Calendar.Month.january.raw(calendar: calendar, day: day, year: 2025),
            .init(calendar: calendar, date: date, body: ([] + (29...31) + (1...31) + (1...8)).chunks(7))
        )
    }

    func testRawJanuaryFirstDayMonday() {
        var calendar = calendar
        calendar.firstWeekday = .init(Day.monday.rawValue)
        var dateComps = dateComps
        dateComps.month = .init(Calendar.Month.january.rawValue)
        let date = calendar.date(from: dateComps)!
        XCTAssertEqual(
            Calendar.Month.january.raw(calendar: calendar, day: day, year: year),
            .init(calendar: calendar, date: date, body: ([] + (1...31) + (1...11)).chunks(7))
        )
    }

    func testJson() {
        let actual: String = .init(data: Calendar.Month.january.raw(calendar: calendar, day: day, year: year).json(), encoding: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        let expected: String = .init(data: try! encoder.encode(try! JSONDecoder().decode(Calendar.Month.Raw.self, from: """
        {
            "body": [
                [31,  1,  2,  3,  4,  5,  6],
                [ 7,  8,  9, 10, 11, 12, 13],
                [14, 15, 16, 17, 18, 19, 20],
                [21, 22, 23, 24, 25, 26, 27],
                [28, 29, 30, 31,  1,  2,  3],
                [ 4,  5,  6,  7,  8,  9, 10]
            ],
            "date": "2024-01-01 05:00:00 +0000",
            "day": 1,
            "header": ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
            "locale": "en_US",
            "month": "January",
            "timeZone": "America/Havana",
            "weekday": "Monday",
            "year": 2024
        }
        """.data(using: .utf8)!)), encoding: .utf8)!
        XCTAssertEqual(actual, expected)
    }

    func testMarkdown() {
        let actual = Calendar.Month.january.raw(calendar: calendar, year: year).markdown().format()
        let expected = """
        |Sun|Mon|Tue|Wed|Thu|Fri|Sat|
        |--:|--:|--:|--:|--:|--:|--:|
        |31 |1  |2  |3  |4  |5  |6  |
        |7  |8  |9  |10 |11 |12 |13 |
        |14 |15 |16 |17 |18 |19 |20 |
        |21 |22 |23 |24 |25 |26 |27 |
        |28 |29 |30 |31 |1  |2  |3  |
        |4  |5  |6  |7  |8  |9  |10 |
        """
        XCTAssertEqual(actual, expected)
    }

    func testHtml() {
        let actual = Calendar.Month.january.raw(calendar: calendar, year: year).html().render()
        let expected = """
        <table>\
        <caption>January 2024</caption>\
        <thead>\
        <tr>\
        <th>Sun</th><th>Mon</th><th>Tue</th><th>Wed</th><th>Thu</th><th>Fri</th><th>Sat</th>\
        </tr>\
        </thead>\
        <tbody>\
        <tr>\
        <td>31</td><td>1</td><td>2</td><td>3</td><td>4</td><td>5</td><td>6</td>\
        </tr>\
        <tr>\
        <td>7</td><td>8</td><td>9</td><td>10</td><td>11</td><td>12</td><td>13</td>\
        </tr>\
        <tr>\
        <td>14</td><td>15</td><td>16</td><td>17</td><td>18</td><td>19</td><td>20</td>\
        </tr>\
        <tr>\
        <td>21</td><td>22</td><td>23</td><td>24</td><td>25</td><td>26</td><td>27</td>\
        </tr>\
        <tr>\
        <td>28</td><td>29</td><td>30</td><td>31</td><td>1</td><td>2</td><td>3</td>\
        </tr>\
        <tr>\
        <td>4</td><td>5</td><td>6</td><td>7</td><td>8</td><td>9</td><td>10</td>\
        </tr>\
        </tbody>\
        </table>
        """
        XCTAssertEqual(actual, expected)
    }
}
