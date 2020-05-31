@testable import ZombieSurvivorKata

import XCTest

class EquipmentsShould: XCTestCase {

    private var equipments = Equipments()
        
    func test_beInitiallyEmpty() {
             
        XCTAssertTrue(equipments.pieces.isEmpty)
    }
    
    func test_haveAInitialMaximumCapacityOfFive() {
                
        XCTAssertEqual(5, equipments.maximumCapacity)
    }
    
    func test_addEquipment() {
        
        let baseballBat = Equipment(name: "Baseball Bat")
        
        equipments = equipments.add(baseballBat)
        
        XCTAssertEqual([baseballBat], equipments.pieces)
    }
    
    func test_addEquipmentUpToMaximumCapacity() {
                
        equipments = addEquipments(cuantity: 6, to: equipments)
        
        XCTAssertEqual(5, equipments.pieces.count)
    }
    
    func test_reduceMaximumCapacityByOne() {
                
        equipments = equipments.reduceMaximumCapacityByOne()

        let maximumCapacityReducedByOne = equipments.maximumCapacity
        
        equipments = equipments.reduceMaximumCapacityByOne()

        let maximumCapacityReducedByTwo = equipments.maximumCapacity

        XCTAssertEqual(4, maximumCapacityReducedByOne)
        XCTAssertEqual(3, maximumCapacityReducedByTwo)
    }
    
    private func addEquipments(cuantity: Int, to equipments: Equipments) -> Equipments {
        
        var newEquipments = equipments
        
        for equipmentNumber in 1...cuantity {
            newEquipments = newEquipments.add(Equipment(name: "Equipment \(equipmentNumber)"))
        }
        
        return newEquipments
    }
}

struct Equipments {
    
    let maximumCapacity: Int
    let pieces: [Equipment]
        
    init() {
        self.init(maximumCapacity: 5, pieces: [])
    }
    
    private init(maximumCapacity: Int, pieces: [Equipment]) {
        self.maximumCapacity = maximumCapacity
        self.pieces = pieces
    }
    
    func add(_ equipment: Equipment) -> Equipments {
        return Equipments(maximumCapacity: maximumCapacity, pieces: createPiecesAdding(equipment))
    }
    
    private func createPiecesAdding(_ equipment: Equipment) -> [Equipment] {
        return haveRoomLeft() ? pieces + [equipment] : pieces
    }
    
    private func haveRoomLeft() -> Bool {
        return pieces.count < maximumCapacity
    }
    
    func reduceMaximumCapacityByOne() -> Equipments {
        return Equipments(maximumCapacity: maximumCapacity - 1, pieces: pieces)
    }
}

struct Equipment: Equatable {
    
    let name: String
}
