struct Game {
    
    private let survivors: [Survivor]
    var numberOfSurvivors: Int { return survivors.count }
    var isEnded: Bool { areAllSurvivorsDead() }
    
    init() {
        self.init(survivors: [])
    }
    
    private init(survivors: [Survivor]) {
        self.survivors = survivors
    }
    
    func addSurvivor(_ survivor: Survivor) -> Game {
        return Game(survivors: createSurvivorsAdding(survivor))
    }
    
    func woundSurvivor(named name: String) -> Game {        
        return Game(survivors: createSurvivorsWoundingSurvivor(named: name))
    }
    
    private func createSurvivorsAdding(_ survivor: Survivor) -> [Survivor] {
        return containsSurvivor(named: survivor.name) ? survivors : survivors + [survivor]
    }
    
    private func containsSurvivor(named name: String) -> Bool {
        return survivors.contains(where: { $0.name == name })
    }
    
    private func areAllSurvivorsDead() -> Bool {
        return survivors.allSatisfy { !$0.isAlive }
    }
    
    private func createSurvivorsWoundingSurvivor(named name: String) -> [Survivor] {
        return survivors.map { return $0.name == name ? $0.wound() : $0 }
    }
}
