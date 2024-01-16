extension [[CustomStringConvertible]] {
    func render() -> String {
        map {
            $0.map {
                $0.description.paddingLeft(toLength: self.first?.first?.description.count ?? 0, withPad: " ", startingAt: 0)
            }.joined(separator: " ")
        }.joined(separator: "\n")
    }
}
