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
             
        XCTAssertEqual([], equipments.pieces)
    }
    
    func test_haveAInitialMaximumCapacityOfFive() {
                
        XCTAssertEqual(5, equipments.maximumCapacity)
    }
    
    func test_addEquipment() {
                
        equipments = equipments.add(baseballBat)
        
        XCTAssertEqual([baseballBat], equipments.pieces)
    }
    
    func test_addEquipmentUpToMaximumCapacity() {
                
        equipments = equipments
            .add(baseballBat)
            .add(fryingPan)
            .add(katana)
            .add(pistol)
            .add(bottledWater)
            .add(molotov)
        
        XCTAssertEqual([baseballBat, fryingPan, katana, pistol, bottledWater], equipments.pieces)
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
