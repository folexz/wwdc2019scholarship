import Foundation
import SpriteKit

typealias GameNodePosition = CGPoint

/// Game Node
class GameNode: SKSpriteNode {
    
    // MARK: - Initializers
    
    override init(texture: SKTexture?,
                  color: NSColor,
                  size: CGSize) {
        isUnusual = false
        
        super.init(texture: texture,
                   color: color,
                   size: size)
    }
    
    convenience init(size: CGSize,
                     texture: SKTexture,
                     nodeColor: GameNodeColor,
                     isUnusual: Bool,
                     position: CGPoint) {
        
        self.init(texture: texture,
                  color: isUnusual ? nodeColor.unusualColor : nodeColor.usualColor,
                  size: size)
        
        self.nodeColor = nodeColor
        self.isUnusual = isUnusual
        
        self.position = position
        self.anchorPoint = .init(x: 0, y: 0)
        
        colorBlendFactor = 1.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Varibales
    
    /// Node color
    var nodeColor: GameNodeColor!
    
    /// Is node unusual
    var isUnusual: Bool
    
    // MARK: - Functions
    
    /// Hides the node
    ///
    /// - Parameter isAnimated: determines if node will be hidden animated or not
    func hide(isAnimated: Bool) {
        if isAnimated {
            let hideAction = SKAction.fadeOut(withDuration: 0.1)
            hideAction.timingMode = .easeInEaseOut
            run(hideAction)
        } else {
            alpha = 0
        }
    }
    
    /// Shows the node
    ///
    /// - Parameter isAnimated: determines if node will be shown animated or not
    func show(isAnimated: Bool) {
        if isAnimated {
            let showAction = SKAction.fadeIn(withDuration: 0.1)
            showAction.timingMode = .easeInEaseOut
            run(showAction)
        } else {
            alpha = 1
        }
    }
}

