
import Builder
import XCTest

struct Person {
    var name: String = ""
    var age: Int = 0
}

final class BuilderTests: XCTestCase {

    func testSetValue() {

        let builder0 = Builder(Person())
        XCTAssertEqual(builder0.build().name, "")
        XCTAssertEqual(builder0.build().age, 0)

        let builder1 = builder0.name("Daniel")
        XCTAssertEqual(builder1.build().name, "Daniel")
        XCTAssertEqual(builder1.build().age, 0)

        let builder2 = builder1.age(35)
        XCTAssertEqual(builder2.build().name, "Daniel")
        XCTAssertEqual(builder2.build().age, 35)
    }

    func testConfiguration() {

        let date = Builder(configuration: DateComponents(), configure: \.date)
            .day(26)
            .month(3)
            .year(2020)
            .calendar(Calendar(identifier: .gregorian))
            .timeZone(TimeZone(secondsFromGMT: 0))
            .build()

        XCTAssertEqual(date, Date(timeIntervalSince1970: 1585180800))
    }

    func testAnyBuilder() {

        let builder = Builder(configuration: DateComponents(), configure: \.date)
            .day(26)
            .month(3)
            .year(2020)
            .calendar(Calendar(identifier: .gregorian))
            .timeZone(TimeZone(secondsFromGMT: 0))
            .eraseToAnyBuilder()

        XCTAssertEqual(builder.build(), Date(timeIntervalSince1970: 1585180800))
    }
}
