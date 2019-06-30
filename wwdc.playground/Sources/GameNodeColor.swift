import Foundation
import SpriteKit

/// Game Node Color
struct GameNodeColor {
    
    // MARK: - Initializers
    
    init(difficulty: GameDifficulty) {
        
        // Hue can be any value from 0 to 360, after that we need to convert to value from 0.0 to 1.0
        let hue = CGFloat(Int.random(in: 0...360)) / 360.0
        
        // We take only bright values of saturation so it can be from 0.65 to 0.9
        let saturation = CGFloat(Int.random(in: 0...25)) / 100.0 + 0.65
        
        // Create colors
        usualColor = NSColor.init(hue: hue,
                                  saturation: saturation,
                                  brightness: 1,
                                  alpha: 1)
        
        unusualColor = NSColor.init(hue: hue,
                                    saturation: saturation,
                                    brightness: CGFloat(difficulty.rawValue),
                                    alpha: 1)
    }
    
    // MARK: - Variables
    
    /// A color for all nodes except the unusual one
    let usualColor: NSColor
    
    /// A color for unusual node
    let unusualColor: NSColor
    
}
