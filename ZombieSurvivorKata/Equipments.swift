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
