@testable import ZombieSurvivorKata

import XCTest

class SurvivorShould: XCTestCase {

    private let baseballBat = Equipment(name: "Baseball Bat")
    private let fryingPan = Equipment(name: "FryingPan")
    private let katana = Equipment(name: "Katana")
    private let pistol = Equipment(name: "Pistol")
    private let bottledWater = Equipment(name: "Bottled Water")
    private let molotov = Equipment(name: "Molotov")
    
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
                
        survivor = survivor.carry(baseballBat)
                
        XCTAssertEqual([baseballBat], survivor.inHandEquipments)
        XCTAssertEqual([], survivor.inReserveEquipments)
    }
    
    func test_carryUpToTwoEquipmentsInHandAndTheRestInReserve() {
        
        survivor = aSurvivorCarring(equipments: baseballBat, fryingPan, katana)
        
        XCTAssertEqual([baseballBat, fryingPan], survivor.inHandEquipments)
        XCTAssertEqual([katana], survivor.inReserveEquipments)
    }
    
    func test_carryUpToFiveEquipments() {
        
        survivor = aSurvivorCarring(equipments: baseballBat, fryingPan, katana, pistol, bottledWater, molotov)
        
        XCTAssertEqual([baseballBat, fryingPan], survivor.inHandEquipments)
        XCTAssertEqual([katana, pistol, bottledWater], survivor.inReserveEquipments)
    }
        
    private func aSurvivorCarring(equipments: Equipment...) -> Survivor {
        
        var survivor = Survivor(name: "Maroon")
        
        for equipment in equipments {
            survivor = survivor.carry(equipment)
        }
        
        return survivor
    }
}

struct Survivor {
    
    private let maximumWounds = 2
    private let maximumInHandEquipments = 2
    private let maximumEquipments = 5
    
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
        return Survivor(name: name,
                        wounds: wounds,
                        inHandEquipments: createInHandEquipmentsAddingEquipment(equipment),
                        inReserveEquipments: createInReserveEquipmentsAddingEquipment(equipment))
    }
    
    private func createInHandEquipmentsAddingEquipment(_ equipment: Equipment) -> [Equipment] {
        return inHandEquipments + (canCarryNewEquipmentInHand() ? [equipment] : [])
    }
    
    private func canCarryNewEquipmentInHand() -> Bool {
        return inHandEquipments.count < maximumInHandEquipments
    }
    
    private func createInReserveEquipmentsAddingEquipment(_ equipment: Equipment) -> [Equipment] {
        return inReserveEquipments + (canCarryNewEquipmentInReserve() ? [equipment] : [])
    }

    private func canCarryNewEquipmentInReserve() -> Bool {
        return !canCarryNewEquipmentInHand() && inReserveEquipments.count < maximumEquipments - maximumInHandEquipments
    }
}

struct Equipment: Equatable {
    
    let name: String
}
