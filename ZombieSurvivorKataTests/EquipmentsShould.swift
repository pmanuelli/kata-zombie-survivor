@testable import ZombieSurvivorKata

import XCTest

class EquipmentsShould: XCTestCase {

    func test_beCreatedEmpty() {
        
        let equipments = Equipments()
     
        XCTAssertEqual(0, equipments.usedCapacity)
    }
}

struct Equipments {
    
    let usedCapacity = 0
}

struct Equipment: Equatable {
    
    let name: String
}
