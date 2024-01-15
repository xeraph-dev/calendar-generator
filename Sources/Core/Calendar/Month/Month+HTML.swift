import Foundation
import Plot

extension Calendar.Month.Raw {
    func html() -> Component {
        return Table(
            caption: TableCaption("\(month) \(year)"),
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
