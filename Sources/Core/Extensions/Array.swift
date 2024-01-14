extension Array {
    func chunks(_ chunkSize: Int) -> [[Element]] {
        stride(from: 0, to: count, by: chunkSize).map {
            Array(self[$0 ..< Swift.min($0 + chunkSize, count)])
        }
    }
}

extension [[CustomStringConvertible]] {
    func render() -> String {
        map {
            $0.map {
                $0.description.paddingLeft(toLength: self.first?.first?.description.count ?? 0, withPad: " ", startingAt: 0)
            }.joined(separator: " ")
        }.joined(separator: "\n")
    }
}
