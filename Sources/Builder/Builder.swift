
@dynamicMemberLookup
public struct Builder<Configuration, Value> {

    public init(configuration: Configuration,
                configure: @escaping (Configuration) -> Value) {
        self.configuration = configuration
        self.configure = configure
    }

    private let configuration: Configuration
    private let configure: (Configuration) -> Value

    public func build() -> Value { configure(configuration) }

    /// Returns a function that can be used to set a value for a property on Root.
    public subscript<Property>(
        dynamicMember keyPath: WritableKeyPath<Configuration, Property>
    ) -> (Property) -> Builder<Configuration, Value> {
        {
            var configuration = self.configuration
            configuration[keyPath: keyPath] = $0
            return Builder(configuration: configuration,
                           configure: self.configure)
        }
    }
}

extension Builder where Configuration == Value {

    public init(_ value: Value) {
        self.init(configuration: value, configure: { $0 })
    }
}
