@testable import ZombieSurvivorKata

import XCTest

class EquipmentsShould: XCTestCase {

    func test_beInitiallyEmpty() {
        
        let equipments = Equipments()
     
        XCTAssertEqual([], equipments.equipments)
    }
    
    func test_addEquipment() {
        
        var equipments = Equipments()
        let baseballBat = Equipment(name: "Baseball Bat")
        
        equipments = equipments.add(baseballBat)
        
        XCTAssertEqual([baseballBat], equipments.equipments)
    }
}

struct Equipments {
    
    let equipments: [Equipment]
    
    init() {
        self.init(equipments: [])
    }
    
    private init(equipments: [Equipment]) {
        self.equipments = equipments
    }
    
    func add(_ equipment: Equipment) -> Equipments {
        return Equipments(equipments: equipments + [equipment])
    }
}

struct Equipment: Equatable {
    
    let name: String
}
