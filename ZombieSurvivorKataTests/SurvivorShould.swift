@testable import ZombieSurvivorKata

import XCTest

class SurvivorShould: XCTestCase {

    func test_haveAName() {
        
        let survivor = Survivor(name: "Chuker")
        
        XCTAssertEqual("Chuker", survivor.name)
    }
}

struct Survivor {
    
    let name: String
}
