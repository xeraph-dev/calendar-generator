extension StringProtocol {
    func paddingLeft<T>(toLength newLength: Int, withPad padString: T, startingAt padIndex: Int) -> String where T: StringProtocol {
        String(String("\(self)".reversed()).padding(toLength: newLength, withPad: padString, startingAt: padIndex).reversed())
    }
}
