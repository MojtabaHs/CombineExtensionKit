import XCTest
import protocol Combine.Publisher

public extension XCTestCase {
    /// A dedicated method for awaiting the output of a publisher
    /// - SeeAlso: [SwiftBySundell: Unit testing Combine-based Swift code] (https://www.swiftbysundell.com/articles/unit-testing-combine-based-swift-code)
    func awaitPublisher<T: Publisher>(
        _ publisher: T,
        timeout: TimeInterval = 3,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> T.Output {
        // Use Swift's Result type to keep track of the result of the Combine pipeline:
        var result: Result<T.Output, Error>?
        let expectation = expectation(description: "Awaiting publisher")

        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error): result = .failure(error)
                case .finished: break
                }

                expectation.fulfill()
            },
            receiveValue: { value in
                result = .success(value)
            }
        )

        // Await the expectation that we created at the top of our test
        wait(for: [expectation], timeout: timeout)
        // Cancel the cancellable to avoid getting any unused variable warnings
        cancellable.cancel()

        // Pass the original file and line number that
        // the utility was called at, to tell XCTest to report
        // any encountered errors at that original call site:
        let unwrappedResult = try XCTUnwrap(
            result,
            "Awaited publisher did not produce any output",
            file: file,
            line: line
        )

        return try unwrappedResult.get()
    }
}
