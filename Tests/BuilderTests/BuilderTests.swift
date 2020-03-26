
import Builder
import XCTest

struct Person {
    var name: String = ""
    var age: Int = 0
}

final class BuilderTests: XCTestCase {

    func testSetValue() {

        let builder0 = Builder(Person())
        XCTAssertEqual(builder0.value.name, "")
        XCTAssertEqual(builder0.value.age, 0)

        let builder1 = builder0.name("Daniel")
        XCTAssertEqual(builder1.value.name, "Daniel")
        XCTAssertEqual(builder1.value.age, 0)

        let builder2 = builder1.age(35)
        XCTAssertEqual(builder2.value.name, "Daniel")
        XCTAssertEqual(builder2.value.age, 35)
    }
}
