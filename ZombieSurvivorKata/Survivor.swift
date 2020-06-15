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
