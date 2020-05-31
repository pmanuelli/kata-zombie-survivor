@testable import ZombieSurvivorKata

import XCTest

class EquipmentsShould: XCTestCase {

    private var equipments = Equipments()
    
    private let baseballBat = Equipment(name: "Baseball Bat")
    private let fryingPan = Equipment(name: "FryingPan")
    private let katana = Equipment(name: "Katana")
    private let pistol = Equipment(name: "Pistol")
    private let bottledWater = Equipment(name: "Bottled Water")
    private let molotov = Equipment(name: "Molotov")
    
    func test_beInitiallyEmpty() {
             
        XCTAssertEqual([], equipments.equipments)
    }
    
    func test_haveAInitialMaximumCapacityOfFive() {
                
        XCTAssertEqual(5, equipments.maximumCapacity)
    }
    
    func test_addEquipment() {
                
        equipments = equipments.add(baseballBat)
        
        XCTAssertEqual([baseballBat], equipments.equipments)
    }
    
    func test_addEquipmentUpToMaximumCapacity() {
                
        equipments = equipments
            .add(baseballBat)
            .add(fryingPan)
            .add(katana)
            .add(pistol)
            .add(bottledWater)
            .add(molotov)
        
        XCTAssertEqual([baseballBat, fryingPan, katana, pistol, bottledWater], equipments.equipments)
    }
    
    func test_reduceMaximumCapacityByOne() {
                
        equipments = equipments.reduceMaximumCapacityByOne()

        let maximumCapacityReducedByOne = equipments.maximumCapacity
        
        equipments = equipments.reduceMaximumCapacityByOne()

        let maximumCapacityReducedByTwo = equipments.maximumCapacity

        XCTAssertEqual(4, maximumCapacityReducedByOne)
        XCTAssertEqual(3, maximumCapacityReducedByTwo)
    }
}

struct Equipments {
    
    let equipments: [Equipment]
    let maximumCapacity: Int
        
    init() {
        self.init(maximumCapacity: 5, equipments: [])
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
