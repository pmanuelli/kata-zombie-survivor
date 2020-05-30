@testable import ZombieSurvivorKata

import XCTest

class SurvivorShould: XCTestCase {

    private let survivorName = "Chuker"
    private lazy var survivor = Survivor(name: survivorName)
    
    func test_haveAName() {
        
        XCTAssertEqual(survivorName, survivor.name)
    }
    
    func test_haveNoInitialWounds() {
                
        XCTAssertEqual(0, survivor.wounds)
    }
}

struct Survivor {
    
    let name: String
    let wounds = 0
}
