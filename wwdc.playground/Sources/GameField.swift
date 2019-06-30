import Foundation
import SpriteKit

/// Game Field
class GameField: SKSpriteNode {
    
    // MARK: - Initializers
    
    override init(texture: SKTexture?,
                  color: NSColor,
                  size: CGSize) {
        level = 2
        fieldSize = 0
        nodeSize = 0
        nodes = []
        
        super.init(texture: texture,
                   color: color,
                   size: size)
    }
    
    convenience init(size: CGSize,
                     position: CGPoint,
                     fieldSize: Int,
                     nodeSize: CGFloat,
                     level: Int,
                     difficulty: GameDifficulty) {
        self.init(texture: nil,
                  color: .clear,
                  size: size)
        
        self.position = position
        anchorPoint = .zero
        
        self.level = level
        self.fieldSize = fieldSize
        self.nodeSize = nodeSize
        
        // Substract 10 points from both width and height so there is some space between nodes
        actualNodeSize = .init(width: nodeSize - 10,
                               height: nodeSize - 10)
        
        self.difficulty = difficulty
        nodeColor = GameNodeColor.init(difficulty: difficulty)
        
        // Generate unusal node position
        unusualNodePosition = GameNodePosition.init(x: Int.random(in: 0..<fieldSize),
                                                    y: Int.random(in: 0..<fieldSize))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Variables
    
    /// Field level, literally the same thing as in Game class
    private var level: Int
    
    /// Field size
    private var fieldSize: Int
    
    /// Node size
    private var nodeSize: CGFloat
    
    /// Actual node size with spaces
    private var actualNodeSize: CGSize!
    
    /// Game difficulty
    var difficulty: GameDifficulty!
    
    /// Node colors: for unusual and usual nodes
    var nodeColor: GameNodeColor!
    
    /// Position of unusual node
    private var unusualNodePosition: GameNodePosition!
    
    /// All nodes
    private var nodes: [GameNode]
    
    // MARK: - Functions
    
    /// Generates new field
    func generateField() {
        
        for i in 0..<fieldSize {
            var type: GameNodeType = Int.random(in: 0...1) == 1 && level > 10 ? .circle : .rounded
            
            for j in 0..<fieldSize {
                let position = CGPoint.init(x: CGFloat(j) * nodeSize,
                                            y: CGFloat(i) * nodeSize)
                
                if level > 20 {
                    if level < 30 {
                        type = Int.random(in: 0...1) == 0 ? .rounded : .circle
                    } else {
                        switch Int.random(in: 0...2) {
                        case 0: type = .rounded
                        case 1: type = .circle
                        case 2: type = .polygon
                        default: return
                        }
                    }
                }
                
                guard let texture = type.texture else { return }
                
                // Create node, add it to all nodes and show it
                let node = GameNode.init(size: actualNodeSize,
                                         texture: texture,
                                         nodeColor: nodeColor,
                                         isUnusual: j == Int(unusualNodePosition.x) && i == Int(unusualNodePosition.y),
                                         position: position)
                
                nodes.append(node)
                addChild(node)
                
                node.hide(isAnimated: false)
                node.show(isAnimated: true)
            }
        }
    }
    
}
