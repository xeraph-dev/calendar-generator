import Foundation
import Markdown

protocol RawCalendar {
    func json() -> Data
    func markdown() -> Markdown.Document
}
