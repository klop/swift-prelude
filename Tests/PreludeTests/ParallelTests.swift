import XCTest
import Prelude

class ParallelTests: XCTestCase {
  func testParallel() {
    let add: (Int) -> (Int) -> Int = { x in { y in x + y } }
    let x = pure(1).delay(0.1)
    let y = pure(2).delay(0.1)

    XCTAssertEqual(3, (sequential <| add <¢> parallel(x) <*> parallel(y)).perform())
  }

  func testRace() {
    let x = pure("tortoise").delay(0.1)
    let y = pure("hare").delay(0.2)

    XCTAssertEqual("tortoise", (sequential <| parallel(x) <|> parallel(y)).perform())
    XCTAssertEqual("tortoise", (sequential <| parallel(y) <|> parallel(x)).perform())
  }
}
