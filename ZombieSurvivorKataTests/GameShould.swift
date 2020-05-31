@testable import ZombieSurvivorKata

import XCTest

class GameShould: XCTestCase {

    func test_haveInitiallyNoSurvivors() {
        
        let game = Game()
        
        XCTAssertEqual(0, game.numberOfSurvivors)
    }
}

struct Game {
    
    let numberOfSurvivors = 0
}
