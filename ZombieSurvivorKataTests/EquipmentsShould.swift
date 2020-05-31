@testable import ZombieSurvivorKata

import XCTest

class EquipmentsShould: XCTestCase {

    func test_beInitiallyEmpty() {
        
        let equipments = Equipments(maximumCapacity: 1)
     
        XCTAssertEqual([], equipments.equipments)
    }
    
    func test_haveAMaximumCapacity() {
        
        let equipments = Equipments(maximumCapacity: 3)
        
        XCTAssertEqual(3, equipments.maximumCapacity)
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
    
    func test_reduceMaximumCapacityByOne() {
        
        var equipments = Equipments(maximumCapacity: 3)
        
        equipments = equipments.reduceMaximumCapacityByOne()
        
        XCTAssertEqual(2, equipments.maximumCapacity)
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
        return Equipments(maximumCapacity: maximumCapacity, equipments: createEquipmentsAdding(equipment))
    }
    
    private func createEquipmentsAdding(_ equipment: Equipment) -> [Equipment] {
        return haveRoomLeft() ? equipments + [equipment] : equipments
    }
    
    private func haveRoomLeft() -> Bool {
        return equipments.count < maximumCapacity
    }
    
    func reduceMaximumCapacityByOne() -> Equipments {
        return Equipments(maximumCapacity: maximumCapacity - 1, equipments: equipments)
    }
}

struct Equipment: Equatable {
    
    let name: String
}
