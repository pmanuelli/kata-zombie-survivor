@testable import ZombieSurvivorKata

import XCTest

class EquipmentsShould: XCTestCase {

    func test_beInitiallyEmpty() {
        
        let equipments = Equipments()
     
        XCTAssertEqual(0, equipments.usedCapacity)
    }
    
    func test_addEquipment() {
        
        var equipments = Equipments()
        let equipment = Equipment(name: "Baseball Bat")
        
        equipments = equipments.add(equipment)
        
        XCTAssertEqual(1, equipments.usedCapacity)
    }
}

struct Equipments {
    
    var usedCapacity: Int { equipments.count }
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
