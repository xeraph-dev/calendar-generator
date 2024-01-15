import Foundation
import Markdown
import Plot

protocol RawCalendar {
    func json() -> Data
    func markdown() -> Markdown.Document
    func html() -> Plot.Component
}
