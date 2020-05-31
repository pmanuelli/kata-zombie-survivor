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
        
        equipments = addPieces(createPieces(cuantity: 6), to: equipments)
        
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
    
    func test_discardLastPieceWhenMaximumCapacityIsReducedAtFullCapacity() {

        let pieces = createPieces(cuantity: 5)
        equipments = addPieces(pieces, to: equipments)

        equipments = equipments.reduceMaximumCapacityByOne()

        XCTAssertEqual(pieces.dropLast(), equipments.pieces)
    }
        
    private func createPieces(cuantity: Int) -> [Equipment] {
        
        var result = [Equipment]()
        
        for pieceNumber in 1...cuantity {
            result = result + [Equipment(name: "Equipment \(pieceNumber)")]
        }
        
        return result
    }
        
    private func addPieces(_ pieces: [Equipment], to equipments: Equipments) -> Equipments {
        
        var newEquipments = equipments
        
        for equipment in pieces {
            newEquipments = newEquipments.add(equipment)
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
        return Equipments(maximumCapacity: maximumCapacity,
                          pieces: createPieces(from: pieces + [equipment], withMaximumCapacity: maximumCapacity))
    }
    
    private func createPieces(from pieces: [Equipment], withMaximumCapacity maximumCapacity: Int) -> [Equipment] {
        return Array(pieces.prefix(maximumCapacity))
    }
        
    func reduceMaximumCapacityByOne() -> Equipments {
        
        return Equipments(maximumCapacity: decreasedMaximumCapacity(),
                          pieces: createPieces(from: pieces, withMaximumCapacity: decreasedMaximumCapacity()))
    }
    
    private func decreasedMaximumCapacity() -> Int {
        return maximumCapacity - 1
    }
}

struct Equipment: Equatable {
    
    let name: String
}
