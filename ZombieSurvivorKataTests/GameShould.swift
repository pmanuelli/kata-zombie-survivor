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
}

struct Game {
    
    let numberOfSurvivors: Int
    
    init() {
        self.init(numberOfSurvivors: 0)
    }
    
    private init(numberOfSurvivors: Int) {
        self.numberOfSurvivors = numberOfSurvivors
    }
    
    func addSurvivor(_ survivor: Survivor) -> Game {
        return Game(numberOfSurvivors: numberOfSurvivors + 1)
    }
}
