import CGCore
import Foundation
import Vapor
import VercelVapor

struct Args: Content {
    var type: String?
    var locale: String?
    var timeZone: String?
    var year: String?
    var month: String?
    var firstWeekday: String?
}

@main
struct API: VaporHandler {
    static func configure(app: Application) async throws {
        app.get { req throws -> Vapor.Response in
            var calendar: Calendar = .init(identifier: .gregorian)
            let args = try req.query.decode(Args.self)

            if let locale = args.locale?.split(separator: "?").first {
                calendar.locale = .init(identifier: .init(locale))
            } else {
                calendar.locale = .current
            }

            if let timeZone = args.timeZone?.split(separator: "?").first,
               let timeZone: TimeZone = .init(identifier: .init(timeZone))
            {
                calendar.timeZone = timeZone
            } else {
                calendar.timeZone = .current
            }

            if let firstWeekDay = args.firstWeekday?.split(separator: "?").first {
                if let firstWeekDay = Int(firstWeekDay) {
                    guard firstWeekDay >= 1, firstWeekDay <= 7 else {
                        throw Abort(.badRequest, reason: "firstWeekday must be an integer between 1 and 7")
                    }
                    calendar.firstWeekday = firstWeekDay
                } else {
                    let firstWeekday = firstWeekDay.lowercased()
                    let index = [calendar.weekdaySymbols, calendar.shortWeekdaySymbols, calendar.veryShortWeekdaySymbols]
                        .map { $0.map { $0.lowercased() }}
                        .compactMap { $0.firstIndex(where: { $0.starts(with: firstWeekday) }) }
                        .first
                    guard let index = index else {
                        throw Abort(.badRequest, reason: "firstWeekday must be a valid weekday")
                    }
                    calendar.firstWeekday = index + 1
                }
            }

            let calendarMonth: Calendar.Month
            if let month = args.month?.split(separator: "?").first {
                if let month = Int(month) {
                    guard month >= 1, month <= 12 else {
                        throw Abort(.badRequest, reason: "month must be an integer between 1 and 12")
                    }
                    calendarMonth = .init(rawValue: month)!
                } else {
                    let month = month.lowercased()
                    let index = [calendar.monthSymbols, calendar.shortMonthSymbols, calendar.veryShortMonthSymbols]
                        .map { $0.map { $0.lowercased() }}
                        .compactMap { $0.firstIndex(where: { $0.starts(with: month) }) }
                        .first
                    guard let index = index else {
                        throw Abort(.badRequest, reason: "month must be a valid month")
                    }
                    calendarMonth = .init(rawValue: index + 1)!
                }
            } else {
                calendarMonth = .init(rawValue: calendar.component(.month, from: Date()))!
            }

            let year = if let year = args.year?.split(separator: "?").first, let year: Int = .init(year) {
                year
            } else {
                calendar.component(.year, from: Date())
            }

            let raw = calendarMonth.raw(calendar: calendar, year: year)

            var calendarResult: RawCalendarResult = .raw

            if let agent = req.headers.first(name: "User-Agent") {
                if agent.contains("curl") || agent.contains("libcurl") {
                    calendarResult = .raw
                } else if agent.contains("Chrome") || agent.contains("Safari") || agent.contains("Firefox") || agent.contains("Mozilla") {
                    calendarResult = .html
                } else {
                    calendarResult = .raw
                }
            }

            if let accept = req.headers.accept.compactMap({ pref -> HTTPMediaType? in
                if pref.mediaType == .any {
                    nil
                } else if pref.mediaType.description == "text/markdown" {
                    pref.mediaType
                } else {
                    switch pref.mediaType {
                    case .html, .json, .plainText: pref.mediaType
                    default: nil
                    }
                }
            }).first {
                calendarResult = if accept.description == "text/markdown" {
                    .markdown
                } else {
                    switch accept {
                    case .html: .html
                    case .json: .json
                    case .plainText: .raw
                    default: throw Abort(.unsupportedMediaType)
                    }
                }
            }

            if let type = args.type?.split(separator: "?").first, let type: RawCalendarResult = .init(rawValue: .init(type)) {
                calendarResult = type
            }

            var headers = HTTPHeaders()
            switch calendarResult {
            case .html: headers.add(name: .contentType, value: "text/html")
            case .markdown: headers.add(name: .contentType, value: "text/markdown")
            case .json: headers.add(name: .contentType, value: "application/json")
            case .raw: headers.add(name: .contentType, value: "text/plain")
            }

            let body = switch calendarResult {
            case .raw: raw.description
            case .json: String(data: raw.json(), encoding: .utf8)!
            case .markdown: raw.markdown().format()
            case .html: raw.html().render()
            }

            return .init(status: .ok, headers: headers, body: .init(string: body))
        }
    }
}
