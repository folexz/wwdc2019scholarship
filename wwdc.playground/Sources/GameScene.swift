import Foundation
import SpriteKit

/// Game Scene
public class GameScene: SKScene {
    
    // MARK: Scene Nodes
    
    /// Main node where all child nodes are contained
    private var gameNode: SKSpriteNode!
    
    /// Shows score
    private var scoreLabel: SKLabelNode!
    
    /// Represents line on the bottom of the scene
    private var timeNode: SKSpriteNode!
    
    /// Shows the highest score user has got
    private var highScoreLabel: SKLabelNode!
    
    /// Shows high score when game is not running
    private var highScoreHugeLabel: SKLabelNode!
    
    /// Start button on the bottom of the scene
    private var startLabel: SKLabelNode!
    
    /// Game difficulty
    public var difficulty: GameDifficulty = .medium
    
    // MARK: - Variables
    
    /// Game
    private var game: Game!
    
    // MARK: - SpriteKit Scene
    
    override public func didMove(to view: SKView) {
        // Fill all nodes
        gameNode = childNode(withName: "gameNode") as? SKSpriteNode
        scoreLabel = childNode(withName: "score") as? SKLabelNode
        timeNode = childNode(withName: "timeNode") as? SKSpriteNode
        
        highScoreLabel = childNode(withName: "highScore") as? SKLabelNode
        highScoreHugeLabel = childNode(withName: "highScoreHuge") as? SKLabelNode
        startLabel = childNode(withName: "startButton") as? SKLabelNode
        
        // Setup the scene
        timeNode.isHidden = true
        highScoreLabel.isHidden = true
        
        // Create the Game
        game = Game(delegate: self,
                    difficulty: difficulty)
        
        // Start playing music
        let action = SKAction.playSoundFileNamed("music",
                                                 waitForCompletion: true)
        run(SKAction.repeatForever(action))
        
    }
    
    override public func mouseDown(with event: NSEvent) {
        let point = event.location(in: self)
        
        // If clicked node is a GameNode
        if let node = nodes(at: point).first as? GameNode {
            // Then call the action depending on is node usual or not
            node.isUnusual ? game.foundNode() : game.wrongNode()
        } else if let node = nodes(at: point).first as? SKLabelNode,
            node == startLabel {
            // Else if clicked node is a START button, then start the game
            startGame()
        }
    }
    
    // MARK: - Functions
    
    /// Starts the game
    private func startGame() {
        // Setup the scene
        timeNode.isHidden = false
        highScoreHugeLabel.isHidden = true
        highScoreLabel.isHidden = false
        highScoreLabel.text = "High score: \(game.highScore)"
        startLabel.isHidden = true
        gameNode.isHidden = false
        scoreLabel.text = "\(game.score)"
        
        updateGameField()
        game.startTimer()
    }
    
    /// Stops the game
    private func stopGame() {
        // Setup the scene
        timeNode.isHidden = true
        highScoreLabel.isHidden = true
        highScoreHugeLabel.isHidden = false
        startLabel.isHidden = false
        gameNode.isHidden = true
        game.resetGame()
        scoreLabel.text = "\(game.highScore)"
        
        cleanUpGameField()
        removeAllActions()
    }
    
    /// Delete current field and genereate a new one
    private func updateGameField() {
        cleanUpGameField()
        game.generateGameField(size: gameNode.size)
    }
    
    /// Delete all child nodes and reset zPosition
    private func cleanUpGameField() {
        gameNode.removeAllChildren()
        gameNode.zRotation = 0
    }
    
}

// MARK: - GameDelegate

extension GameScene: GameDelegate {
    
    /// Called when Game's time is updated
    func gameDelegateTimeUpdated(_ game: Game) {
        // Count line width on the bottom of the scene by percents (0.0 - 1.0)
        let estimatedPercents = CGFloat(game.time / game.maxTime)
        
        // Count actual width of node
        let newWidth = size.width * estimatedPercents
        
        // Apply it
        let newSize = CGSize.init(width: newWidth,
                                  height: timeNode.size.height)
        timeNode.size = newSize
        
        // Hide the line if the game is over
        guard game.time < 0 else { return }
        timeNode.isHidden = true
        stopGame()
    }
    
    /// Called when Game's level is updated
    func gameDelegateLevelUpdated(_ game: Game) {
        updateGameField()
    }
    
    /// Called when Game's score is updated
    func gameDelegateScoreUpdated(_ game: Game) {
        // Create update animation
        let expandAction = SKAction.scale(to: 1.5, duration: 0.1)
        expandAction.timingMode = .easeIn
        
        let reduceAction = SKAction.scale(to: 1, duration: 0.1)
        reduceAction.timingMode = .easeInEaseOut
        
        let sequence = SKAction.sequence([expandAction, reduceAction])
        
        // Run it
        scoreLabel.run(sequence)
        
        // Update the text
        scoreLabel.text = "\(game.score)"
        highScoreLabel.text = "High score: \(game.highScore)"
    }
    
    /// Rotate the field by 180 degrees
    func gameDelegateShouldRotateGameField(_ game: Game) {
        gameNode.zRotation = 0.5 * .pi
    }
    
    /// Called when Scene has to run some ation
    ///
    /// - Parameters:
    ///   - action: Action that scene should run
    func gameDelegate(_ game: Game, runAction action: SKAction) {
        run(action)
    }
    
    /// Update color of line on the bottom of the scene and add field to scene
    ///
    /// - Parameters:
    ///   - gameField: Generated Game Field
    func gameDelegate(_ game: Game, didGenerate gameField: GameField) {
        
        timeNode.color = game.gameField.nodeColor.usualColor
        gameNode.addChild(gameField)
    }
    
}
