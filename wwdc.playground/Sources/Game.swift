import Foundation
import SpriteKit

/// Game delegate that called on GameScene
protocol GameDelegate {
    func gameDelegateLevelUpdated(_ game: Game)
    func gameDelegateScoreUpdated(_ game: Game)
    func gameDelegateTimeUpdated(_ game: Game)
    func gameDelegateShouldRotateGameField(_ game: Game)
    func gameDelegate(_ game: Game, didGenerate gameField: GameField)
    func gameDelegate(_ game: Game, runAction action: SKAction)
}

/// Game class, stores difficulty, current level, time and score
class Game {
    
    // MARK: - Initializers
    
    init(delegate: GameDelegate,
         difficulty: GameDifficulty,
         level: Int = 2,
         score: Int = 0,
         time: Double = 15,
         highScore: Int = 0) {
        self.delegate = delegate
        self.difficulty = difficulty
        self.level = level
        self.score = score
        self.time = time
        self.highScore = highScore
        maxTime = time
    }
    
    // MARK: - Variables
    
    /// Game delegate
    var delegate: GameDelegate
    
    /// Game difficulty
    var difficulty: GameDifficulty
    
    /// Current game field
    var gameField: GameField!
    
    /// Current game level
    var level: Int {
        didSet {
            // Update the scene
            delegate.gameDelegateLevelUpdated(self)
        }
    }
    
    /// Current game score
    var score: Int {
        didSet {
            // Update high score if new score is more than highest
            highScore = score > highScore ? score : highScore
            
            // Update the scene
            delegate.gameDelegateScoreUpdated(self)
        }
    }
    
    /// Current remaining time until lose
    var time: Double {
        didSet {
            // Update the scene
            delegate.gameDelegateTimeUpdated(self)
            
            // By default, player has 15 seconds until lose, but if he will find different elements fast, he could increase maximum time
            maxTime = time > maxTime ? time : maxTime
        }
    }
    
    /// Current highest score
    var highScore: Int
    
    /// Current maximum time, 15 by default
    var maxTime: Double
    
    /// Resets the game
    func resetGame() {
        // Level literally means count of items in row and column, so level = 2 means there is 2x2 matrix on the screen, 10 - 10x10, etc.
        level = 2
        time = 15
        score = 0
    }
    
    // MARK: - Functions
    
    /// Generates new game field
    ///
    /// - Parameter size: actual size of field on scene
    func generateGameField(size: CGSize) {
        
        // If level > 8, then game randoms field size from 5 to 8 elemnts in row/column
        let fieldSize = level > 8 ? Int.random(in: 0...3) + 5 : level
        
        // Calculate node size
        let nodeSize = size.width / CGFloat(fieldSize)
        
        // Randomly rotate field
        if Int.random(in: 0...1) == 0 && level < 21 {
            delegate.gameDelegateShouldRotateGameField(self)
        }
        
        // Create game field
        gameField = GameField.init(size: size,
                                   position: CGPoint.init(x: -size.width / 2,
                                                          y: -size.width / 2),
                                   fieldSize: fieldSize,
                                   nodeSize: nodeSize,
                                   level: level,
                                   difficulty: difficulty)
        
        // Generate it
        gameField.generateField()
        
        // Update the scene
        delegate.gameDelegate(self,
                              didGenerate: gameField)
    }
    
    /// Starts game timer
    func startTimer() {
        
        // Create timer action
        let waitAction = SKAction.wait(forDuration: 0.01)
        let updateAction = SKAction.run {
            self.time -= 0.01
        }
        
        let action = SKAction.sequence([waitAction, updateAction])
        
        // Update the scene
        delegate.gameDelegate(self, runAction: SKAction.repeatForever(action))
    }
    
    /// Called in case correct node has been selected
    func foundNode() {
        level += 1
        score += 1
        time += 2
        
        let action = SKAction.playSoundFileNamed("success",
                                                 waitForCompletion: false)
        delegate.gameDelegate(self, runAction: action)
    }
    
    /// Called in case wrong node has been selected
    func wrongNode() {
        time -= 0.5
        
        let action = SKAction.playSoundFileNamed("failure",
                                                 waitForCompletion: false)
        delegate.gameDelegate(self, runAction: action)
    }
    
}
