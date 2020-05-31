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
    
    func test_dieIfReceivesTwoWounds() {
        
        survivor = survivor.wound()
        
        let isAliveWithOneWound = survivor.isAlive
        
        survivor = survivor.wound()
        
        let isAliveWithTwoWounds = survivor.isAlive
        
        XCTAssertTrue(isAliveWithOneWound)
        XCTAssertFalse(isAliveWithTwoWounds)
    }
    
    func test_receiveTwoWoundsMaximum() {
        
        survivor = survivor.wound().wound().wound()
        
        XCTAssertEqual(2, survivor.wounds)
    }
    
    func test_beAbleToPerformThreeActionsPerTurn() {
        
        XCTAssertEqual(3, survivor.actionsPerTurn)
    }
    
    func test_carryEquipment() {
        
        let baseballBat = Equipment(name: "Baseball Bat")
        let fryingPan = Equipment(name: "Frying Pan")
        
        survivor = survivor.carry(baseballBat).carry(fryingPan)
        
        let equipments = survivor.equipments
        
        XCTAssertTrue(equipments.contains(baseballBat))
        XCTAssertTrue(equipments.contains(fryingPan))
        XCTAssertEqual(2, equipments.count)
    }
}

struct Survivor {
    
    private let maximumWounds = 2
    
    let name: String
    let wounds: Int
    var isAlive: Bool { wounds < maximumWounds }
    let actionsPerTurn = 3
    let equipments: [Equipment]
    
    init(name: String) {
        self.init(name: name, wounds: 0, equipments: [])
    }
    
    private init(name: String, wounds: Int, equipments: [Equipment]) {
        self.name = name
        self.wounds = wounds
        self.equipments = equipments
    }
    
    func wound() -> Survivor {
        return Survivor(name: name, wounds: min(wounds + 1, maximumWounds), equipments: equipments)
    }
    
    func carry(_ equipment: Equipment) -> Survivor {
        return Survivor(name: name, wounds: wounds, equipments: equipments + [equipment])
    }
}

struct Equipment: Equatable {
    
    let name: String
}
