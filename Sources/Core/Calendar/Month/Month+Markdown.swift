import Foundation
import Markdown

public extension Calendar.Month.Raw {
    func markdown() -> Document {
        Document(
            Table(
                columnAlignments: header.map { _ in .right },
                header: .init(header.map { Table.Cell(Text($0)) }),
                body: .init(body.map { Table.Row(
                    $0.map { Table.Cell(Text($0.description)) }
                ) })
            )
        )
    }
}
