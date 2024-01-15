import Foundation
import Markdown
import Plot

public enum RawCalendarResult: String {
    case raw, json, markdown, html
}

protocol RawCalendar {
    func json() -> Data
    func markdown() -> Markdown.Document
    func html() -> Plot.Component
}
