@testable import ZombieSurvivorKata

import XCTest

class GameShould: XCTestCase {

    func test_haveInitiallyNoSurvivors() {
        
        let game = Game()
        
        XCTAssertEqual(0, game.numberOfSurvivors)
    }
    
    func test_allowSurvivorsToBeAdded() {
        
        let gameWithNoSurvivors = Game()
        
        let gameWithOneSurvivor = gameWithNoSurvivors.addSurvivor(Survivor(name: "Papita"))
        let gameWithTwoSurvivors = gameWithOneSurvivor.addSurvivor(Survivor(name: "Julian"))
        
        XCTAssertEqual(1, gameWithOneSurvivor.numberOfSurvivors)
        XCTAssertEqual(2, gameWithTwoSurvivors.numberOfSurvivors)
    }
    
    func test_haveSurvivorsWithUniqueNames() {
        
        let survivorName = "Papita"
        
        var game = Game()
        
        game = game.addSurvivor(Survivor(name: survivorName))
        game = game.addSurvivor(Survivor(name: survivorName))
        
        XCTAssertEqual(1, game.numberOfSurvivors)
    }
}

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
        
        var newSurvivors = survivors
        
        if !survivors.contains(where: { $0.name == survivor.name }) {
            newSurvivors = newSurvivors + [survivor]
        }
        
        return Game(survivors: newSurvivors)
    }
}
