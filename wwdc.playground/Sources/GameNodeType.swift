import Foundation
import SpriteKit

/// Game Node Type
enum GameNodeType: String {
    case rounded
    case circle
    case polygon
    
    /// Image of node
    private var image: NSImage? {
        return NSImage.init(named: rawValue)
    }
    
    /// SpriteKit texture of node
    var texture: SKTexture? {
        guard image != nil else { return nil }
        return SKTexture.init(image: image!)
    }
}
