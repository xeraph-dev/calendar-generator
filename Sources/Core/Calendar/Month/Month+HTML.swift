import Foundation
import Plot

public extension Calendar.Month.Raw {
    func html() -> Component {
        return Table(
            caption: TableCaption {
                Div {
                    Span("\(month) \(year)").style("float: left")
                    Span(locale).style("float: right")
                }
                Span(timeZone).style("float: right")
            },
            header: TableRow {
                for day in header {
                    TableHeaderCell(Text(day))
                }
            }) {
                for week in body {
                    TableRow {
                        for day in week {
                            TableCell(Text(day.description))
                        }
                    }
                }
            }
    }
}
