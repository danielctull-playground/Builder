
public protocol Builder {
    associatedtype Value
    func build() -> Value
}

@dynamicMemberLookup
public struct ConfigurableBuilder<Configuration, Value>: Builder {

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
    ) -> (Property) -> ConfigurableBuilder<Configuration, Value> {
        {
            var configuration = self.configuration
            configuration[keyPath: keyPath] = $0
            return ConfigurableBuilder(configuration: configuration,
                                       configure: self.configure)
        }
    }
}

extension ConfigurableBuilder where Configuration == Value {

    public init(_ value: Value) {
        self.init(configuration: value, configure: { $0 })
    }
}

extension Builder {

    public func eraseToAnyBuilder() -> AnyBuilder<Value> {
        AnyBuilder(build: build)
    }
}

public struct AnyBuilder<Value>: Builder {

    public func build() -> Value { _build() }

    private let _build: () -> Value
    init(build: @escaping () -> Value) {
        _build = build
    }
}
