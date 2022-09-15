import Combine

public extension Combine.Publisher {
    func mapErrorToSwiftError() -> Publishers.MapError<Self, Error> {
        mapError { $0 as Error }
    }
}
