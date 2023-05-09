@testable import GildedRose
import XCTest

class GildedRoseTests: XCTestCase {
    func testNameDoesntChange() throws {
        let items = [Item(name: "foo", sellIn: 0, quality: 0)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(app.items[0].name, "foo")
    }

    func testDailyUpdate() throws {
        let startingSellIn = 10
        let startingQuality = 5
        let items = [Item(name: "foo", sellIn: startingSellIn, quality: startingQuality)]
        let app = GildedRose(items: items)
        app.updateQuality()
        let item = items.first!
        XCTAssertLessThan(item.sellIn, startingSellIn)
        XCTAssertLessThan(item.quality, startingQuality)
    }

    func testDegradationSpeedAfterSellBy() throws {
        let name = "foo"
        let startingQuality = 5
        let items = [
            Item(name: name, sellIn: 1, quality: startingQuality),
            Item(name: name, sellIn: 0, quality: startingQuality)
        ]
        let app = GildedRose(items: items)
        app.updateQuality()

        let fresh = items.first!
        let expired = items.last!

        let freshQualityDelta = startingQuality - fresh.quality
        let expiredQualityDelta =  startingQuality - expired.quality

        XCTAssertEqual(freshQualityDelta * 2, expiredQualityDelta)
    }

    func testQualityNeverNegative() throws {
        let name = "foo"
        let startingQuality = 0
        let items = [
            Item(name: name, sellIn: 0, quality: startingQuality)
        ]
        let app = GildedRose(items: items)
        app.updateQuality()

        XCTAssertGreaterThanOrEqual(items.first!.quality, 0)
    }

    func testAgedBrieIncreasingQuality() throws {
        let startingSellIn = 10
        var startingQuality = 5
 
        let items = [Item(name: "Aged Brie", sellIn: startingSellIn, quality: startingQuality)]
        let app = GildedRose(items: items)
        app.updateQuality()

        let agedBrie = items.first!
        XCTAssertGreaterThan(agedBrie.quality, startingQuality)
    }
}
