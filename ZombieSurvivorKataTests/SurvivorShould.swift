@testable import ZombieSurvivorKata

import XCTest

class SurvivorShould: XCTestCase {

    private let survivorName = "Chuker"
    private lazy var survivor = Survivor(name: survivorName)
    
    func test_haveAName() {
        
        XCTAssertEqual(survivorName, survivor.name)
    }
    
    func test_beInitiallyUnwounded() {
                
        XCTAssertEqual(0, survivor.wounds)
    }
    
    func test_beInitiallyAlive() {
        
        XCTAssertTrue(survivor.isAlive)
    }
    
    func test_receiveWounds() {
        
        survivor = survivor.wound()
        
        XCTAssertEqual(1, survivor.wounds)
    }    
}

struct Survivor {
    
    let name: String
    let wounds: Int
    let isAlive = true
    
    init(name: String) {
        self.init(name: name, wounds: 0)
    }
    
    private init(name: String, wounds: Int) {
        self.name = name
        self.wounds = wounds
    }
    
    func wound() -> Survivor {
        return Survivor(name: name, wounds: wounds + 1)
    }
}
