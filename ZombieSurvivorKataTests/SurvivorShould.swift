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
        
        survivor = carry(equipments: [baseballBat, fryingPan, katana], to: survivor)
        
        XCTAssertEqual([baseballBat, fryingPan], survivor.inHandEquipments)
        XCTAssertEqual([katana], survivor.inReserveEquipments)
    }
    
    func test_carryUpToFiveEquipments() {
        
        survivor = carry(equipmentsCount: 5, to: survivor)
        
        XCTAssertEqual(2, survivor.inHandEquipments.count)
        XCTAssertEqual(3, survivor.inReserveEquipments.count)
    }
    
    func test_reduceCarringCapacityByOneIfWounded() {
        
        survivor = survivor.wound()
        survivor = carry(equipmentsCount: 5, to: survivor)
        
        XCTAssertEqual(2, survivor.inHandEquipments.count)
        XCTAssertEqual(2, survivor.inReserveEquipments.count)
    }
    
    func test_notDiscardEquipmentWhenWoundedIfHasEnoughCapacity() {
        
        survivor = carry(equipmentsCount: 4, to: survivor)
        survivor = survivor.wound()
        
        XCTAssertEqual(2, survivor.inHandEquipments.count)
        XCTAssertEqual(2, survivor.inReserveEquipments.count)
    }
    
    func test_discardLastEquipmentWhenWoundedAtFullCapacity() {
        
        survivor = carry(equipments: [baseballBat, fryingPan, katana, pistol, bottledWater], to: survivor)
        survivor = survivor.wound()
        
        XCTAssertEqual([baseballBat, fryingPan], survivor.inHandEquipments)
        XCTAssertEqual([katana, pistol], survivor.inReserveEquipments)

    }
                
    private func carry(equipments: [Equipment], to survivor: Survivor) -> Survivor {
        
        var newSurvivor = survivor
        
        for equipment in equipments {
            newSurvivor = newSurvivor.carry(equipment)
        }
        
        return newSurvivor
    }
        
    private func carry(equipmentsCount: Int, to survior: Survivor) -> Survivor {
        
        var newSurvivor = survior
        
        for equipmentNumber in 1...equipmentsCount {
            newSurvivor = newSurvivor.carry(Equipment(name: "Equipment \(equipmentNumber)"))
        }
        
        return newSurvivor
    }
}

struct Survivor {
    
    private let maximumWounds = 2
    private let maximumInHandEquipments = 2
    
    let name: String
    let wounds: Int
    var isAlive: Bool { wounds < maximumWounds }
    let actionsPerTurn = 3
    
    private let equipments: Equipments
    
    var inHandEquipments: [Equipment] { createInHandEquipments() }
    var inReserveEquipments: [Equipment] { createInReserveEquipments() }
    
    init(name: String) {
        self.init(name: name, wounds: 0, equipments: Equipments())
    }
    
    private init(name: String, wounds: Int, equipments: Equipments) {
        self.name = name
        self.wounds = wounds
        self.equipments = equipments
    }
    
    func wound() -> Survivor {
                
        return Survivor(name: name,
                        wounds: increasedWounds(),
                        equipments: equipments.reduceMaximumCapacityByOne())
    }
    
    private func increasedWounds() -> Int {
        return min(wounds + 1, maximumWounds)
    }
    
    func carry(_ equipment: Equipment) -> Survivor {
        
        return Survivor(name: name,
                        wounds: wounds,
                        equipments: equipments.add(equipment))
    }
    
    private func createInHandEquipments() -> [Equipment] {
        return Array(equipments.pieces.prefix(maximumInHandEquipments))
    }
    
    private func createInReserveEquipments() -> [Equipment] {
        return Array(equipments.pieces.dropFirst(maximumInHandEquipments))
    }
}
