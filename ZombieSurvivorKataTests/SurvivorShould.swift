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
    
    func test_carryEquipmentInHand() {
        
        let baseballBat = Equipment(name: "Baseball Bat")
        
        survivor = survivor.carry(baseballBat)
                
        XCTAssertEqual([baseballBat], survivor.inHandEquipments)
        XCTAssertEqual([], survivor.inReserveEquipments)
    }
    
    func test_carryUpToTwoEquipmentsInHandAndTheRestInReserve() {
        
        let baseballBat = Equipment(name: "Baseball Bat")
        let fryingPan = Equipment(name: "FryingPan")
        let katana = Equipment(name: "Katana")
        
        survivor = survivor.carry(baseballBat).carry(fryingPan).carry(katana)
        
        XCTAssertEqual([baseballBat, fryingPan], survivor.inHandEquipments)
        XCTAssertEqual([katana], survivor.inReserveEquipments)
    }
}

struct Survivor {
    
    private let maximumWounds = 2
    
    let name: String
    let wounds: Int
    var isAlive: Bool { wounds < maximumWounds }
    let actionsPerTurn = 3
    let inHandEquipments: [Equipment]
    let inReserveEquipments: [Equipment]
    
    init(name: String) {
        self.init(name: name, wounds: 0, inHandEquipments: [], inReserveEquipments: [])
    }
    
    private init(name: String, wounds: Int, inHandEquipments: [Equipment], inReserveEquipments: [Equipment]) {
        self.name = name
        self.wounds = wounds
        self.inHandEquipments = inHandEquipments
        self.inReserveEquipments = inReserveEquipments
    }
    
    func wound() -> Survivor {
        return Survivor(name: name,
                        wounds: min(wounds + 1, maximumWounds),
                        inHandEquipments: inHandEquipments,
                        inReserveEquipments: inReserveEquipments)
    }
    
    func carry(_ equipment: Equipment) -> Survivor {
        
        let allEquipment = inHandEquipments + inReserveEquipments + [equipment]
        let inHandEquipment = Array(allEquipment.prefix(2))
        let inReserveEquipment = Array(allEquipment.dropFirst(2))
        
        return Survivor(name: name,
                        wounds: wounds,
                        inHandEquipments: inHandEquipment,
                        inReserveEquipments: inReserveEquipment)
    }
}

struct Equipment: Equatable {
    
    let name: String
}
