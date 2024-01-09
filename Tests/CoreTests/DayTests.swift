@testable import CGCore
import Foundation
import XCTest

class DayTests: XCTestCase {
    var calendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = Day.sunday.rawValue
        calendar.timeZone = .init(identifier: "America/Havana")!
        calendar.locale = .init(identifier: "en_US")
        return calendar
    }

    let year = 2024

    func testRawJanuary() {
        XCTAssertEqual(
            Month.january.raw(calendar: calendar, year: year),
            (calendar.shortWeekdaySymbols + ([]
                    + [31]
                    + (1 ... 31)
                    + (1 ... 10)
            ).map { $0.description }).chunks(7)
        )
    }

    func testRawFebruary() {
        XCTAssertEqual(
            Month.february.raw(calendar: calendar, year: year),
            (calendar.shortWeekdaySymbols + ([]
                    + (28 ... 31)
                    + (1 ... 29)
                    + (1 ... 9)
            ).map { $0.description }).chunks(7)
        )
    }

    func testRawMarch() {
        XCTAssertEqual(
            Month.march.raw(calendar: calendar, year: year),
            (calendar.shortWeekdaySymbols + ([]
                    + (25 ... 29)
                    + (1 ... 31)
                    + (1 ... 6)
            ).map { $0.description }).chunks(7)
        )
    }

    func testRawApril() {
        XCTAssertEqual(
            Month.april.raw(calendar: calendar, year: year),
            (calendar.shortWeekdaySymbols + ([]
                    + [31]
                    + (1 ... 30)
                    + (1 ... 11)
            ).map { $0.description }).chunks(7)
        )
    }

    func testRawMay() {
        XCTAssertEqual(
            Month.may.raw(calendar: calendar, year: year),
            (calendar.shortWeekdaySymbols + ([]
                    + (28 ... 30)
                    + (1 ... 31)
                    + (1 ... 8)
            ).map { $0.description }).chunks(7)
        )
    }

    func testRawJune() {
        XCTAssertEqual(
            Month.june.raw(calendar: calendar, year: year),
            (calendar.shortWeekdaySymbols + ([]
                    + (26 ... 31)
                    + (1 ... 30)
                    + (1 ... 6)
            ).map { $0.description }).chunks(7)
        )
    }

    func testRawJuly() {
        XCTAssertEqual(
            Month.july.raw(calendar: calendar, year: year),
            (calendar.shortWeekdaySymbols + ([]
                    + [30]
                    + (1 ... 31)
                    + (1 ... 10)
            ).map { $0.description }).chunks(7)
        )
    }

    func testRawAugust() {
        XCTAssertEqual(
            Month.august.raw(calendar: calendar, year: year),
            (calendar.shortWeekdaySymbols + ([]
                    + (28 ... 31)
                    + (1 ... 31)
                    + (1 ... 7)
            ).map { $0.description }).chunks(7)
        )
    }

    func testRawSeptember() {
        XCTAssertEqual(
            Month.september.raw(calendar: calendar, year: year),
            (calendar.shortWeekdaySymbols + ([]
                    + (1 ... 30)
                    + (1 ... 12)
            ).map { $0.description }).chunks(7)
        )
    }

    func testRawOctober() {
        XCTAssertEqual(
            Month.october.raw(calendar: calendar, year: year),
            (calendar.shortWeekdaySymbols + ([]
                    + (29 ... 30)
                    + (1 ... 31)
                    + (1 ... 9)
            ).map { $0.description }).chunks(7)
        )
    }

    func testRawNovember() {
        XCTAssertEqual(
            Month.november.raw(calendar: calendar, year: year),
            (calendar.shortWeekdaySymbols + ([]
                    + (27 ... 31)
                    + (1 ... 30)
                    + (1 ... 7)
            ).map { $0.description }).chunks(7)
        )
    }

    func testRawDecember() {
        XCTAssertEqual(
            Month.december.raw(calendar: calendar, year: year),
            (calendar.shortWeekdaySymbols + ([]
                    + (1 ... 31)
                    + (1 ... 11)
            ).map { $0.description }).chunks(7)
        )
    }

    func testRawJanuary2025() {
        XCTAssertEqual(
            Month.january.raw(calendar: calendar, year: 2025),
            (calendar.shortWeekdaySymbols + ([]
                    + (29 ... 31)
                    + (1 ... 31)
                    + (1 ... 8)
            ).map { $0.description }).chunks(7)
        )
    }

    func testRawJanuarFirstDayMonday() {
        var calendar = calendar
        calendar.firstWeekday = Day.monday.rawValue
        XCTAssertEqual(
            Month.january.raw(calendar: calendar, year: year),
            (calendar.shortWeekdaySymbols + ([]
                    + (1 ... 31)
                    + (1 ... 11)
            ).map { $0.description }).chunks(7)
        )
    }
}
