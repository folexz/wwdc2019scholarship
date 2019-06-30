import Foundation

/// Game Difficulty
///
/// - children: Different node can be found by anyone
/// - easy: Different node can be found by almost everyone
/// - medium: Different node is harder to found
/// - hard: Very hard to find a different node
public enum GameDifficulty: Double {
    case children = 0.6
    case easy = 0.7
    case medium = 0.8
    case hard = 0.9
}
