@testable import ZombieSurvivorKata

import XCTest

class SurvivorShould: XCTestCase {

    private let survivorName = "Chuker"
    
    func test_haveAName() {
        
        let survivor = Survivor(name: survivorName)
        
        XCTAssertEqual(survivorName, survivor.name)
    }
    
    func test_haveNoInitialWounds() {
        
        let survivor = Survivor(name: survivorName)
        
        XCTAssertEqual(0, survivor.wounds)
    }
}

struct Survivor {
    
    let name: String
    let wounds = 0
}
