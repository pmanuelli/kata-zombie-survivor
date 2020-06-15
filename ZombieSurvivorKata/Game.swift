struct Game {
    
    private let survivors: [Survivor]
    var numberOfSurvivors: Int { return survivors.count }
    
    init() {
        self.init(survivors: [])
    }
    
    private init(survivors: [Survivor]) {
        self.survivors = survivors
    }
    
    func addSurvivor(_ survivor: Survivor) -> Game {
        return Game(survivors: createSurvivorsAdding(survivor))
    }
    
    private func createSurvivorsAdding(_ survivor: Survivor) -> [Survivor] {
        return containsSurvivorNamed(survivor.name) ? survivors : survivors + [survivor]
    }
    
    private func containsSurvivorNamed(_ name: String) -> Bool {
        return survivors.contains(where: { $0.name == name })
    }
}
