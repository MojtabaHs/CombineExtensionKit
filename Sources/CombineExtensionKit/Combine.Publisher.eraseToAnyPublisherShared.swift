import protocol Combine.Publisher
import struct Combine.AnyPublisher

public extension Combine.Publisher {
    func eraseToAnyPublisher(shared: Bool) -> AnyPublisher<Self.Output, Self.Failure> {
        shared ? share().eraseToAnyPublisher() : eraseToAnyPublisher()
    }
}
