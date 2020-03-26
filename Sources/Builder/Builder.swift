
public struct Builder<Value> {

    public init(_ value: Value) {
        self.value = value
    }

    public let value: Value

    public func setValue<V>(_ v: V, for keyPath: WritableKeyPath<Value, V>) -> Self {
        var value = self.value
        value[keyPath: keyPath] = v
        return Builder(value)
    }
}
