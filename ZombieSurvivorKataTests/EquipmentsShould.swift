@testable import ZombieSurvivorKata

import XCTest

class EquipmentsShould: XCTestCase {

    func test_beInitiallyEmpty() {
        
        let equipments = Equipments(maximumCapacity: 1)
     
        XCTAssertEqual([], equipments.equipments)
    }
    
    func test_addEquipment() {
        
        var equipments = Equipments(maximumCapacity: 1)
        let baseballBat = Equipment(name: "Baseball Bat")
        
        equipments = equipments.add(baseballBat)
        
        XCTAssertEqual([baseballBat], equipments.equipments)
    }
    
    func test_addEquipmentUpToMaximumCapacity() {
        
        var equipments = Equipments(maximumCapacity: 2)
        let baseballBat = Equipment(name: "Baseball Bat")
        let fryingPan = Equipment(name: "FryingPan")
        let katana = Equipment(name: "Katana")
        
        equipments = equipments.add(baseballBat).add(fryingPan).add(katana)
        
        XCTAssertEqual([baseballBat, fryingPan], equipments.equipments)
    }
}

struct Equipments {
    
    let equipments: [Equipment]
    let maximumCapacity: Int
        
    init(maximumCapacity: Int) {
        self.init(maximumCapacity: maximumCapacity, equipments: [])
    }
    
    private init(maximumCapacity: Int, equipments: [Equipment]) {
        self.maximumCapacity = maximumCapacity
        self.equipments = equipments
    }
    
    func add(_ equipment: Equipment) -> Equipments {
        
        var equipments = self.equipments
        
        if equipments.count < maximumCapacity {
            equipments = equipments + [equipment]
        }
        
        return Equipments(maximumCapacity: maximumCapacity, equipments: equipments)
    }
}

struct Equipment: Equatable {
    
    let name: String
}
