
@dynamicMemberLookup
public struct Builder<Value> {

    public init(_ value: Value) {
        self.value = value
    }

    public let value: Value

    /// Returns a function that can be used to set a value for a property on Root.
    public subscript<V>(
        dynamicMember keyPath: WritableKeyPath<Value, V>
    ) -> (V) -> Builder<Value> {
        {
            var value = self.value
            value[keyPath: keyPath] = $0
            return Builder(value)
        }
    }
}
