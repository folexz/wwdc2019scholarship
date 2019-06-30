/*:
 ### Felix Zubarev WWDC 2019 Scholarships Project
 
 My name is Felix Zubarev and I am a 20-year old, living in Saint-Petersburg, Russia.
 
 Let me tell you some info about this playground before you run and play it.
 
 First of all, some instructions:
 1) Open Assistant Editor (Cmd-Alt-Enter) and choose Live View mode
 2) Feel free to review sources they are all commented
 3) Also, feel free to change the difficulty below for more fun
 
 Now about this project. It's a game where you need to find a different element from all others.
 At the moment it's just a prototype with a few different elements (rounded square, circle, and hexagon) and not that much of gameplay.
 I've found that interesting to make a game like this as it may improve sight or attention (in my opinion).
 The idea came to me about a month ago or so, but I didn't have time to write it, but when WWDC Scholarship has opened I was thinking what should I do in my submission and decided to make this game.
 
 I have plans to add some boosters, improve gameplay and probably release the game by June-July.
 
 That's all! Hope you will enjoy the game.
 
 Oh, and don't forget to turn the sound on!

 ### Licences
 
 Music:
 
 "River Fire" Kevin MacLeod [incompetech.com](incompetech.com)
 
 Licensed under Creative Commons: [By Attribution 3.0 License](http://creativecommons.org/licenses/by/3.0/)
 
 Success sound:
 
 [Source](https://freesound.org/people/GabrielAraujo/sounds/242501/)
 
 [Creative Commons 0 License](http://creativecommons.org/publicdomain/zero/1.0/)
 
 Failure sound:
 
 [Source](https://freesound.org/people/thirteenthfail/sounds/268159/)
 
 [Creative Commons 0 License](http://creativecommons.org/publicdomain/zero/1.0/)
 */
import PlaygroundSupport
import Foundation
import SpriteKit

// Create scene and show it
let frame = CGRect.init(x: 0, y: 0, width: 1024, height: 768)
let sceneView = SKView.init(frame: frame)

if let scene = GameScene(fileNamed: "GameScene") {
    scene.scaleMode = .aspectFit
    scene.difficulty = .hard // <-- feel free to try different difficulties
    
    sceneView.presentScene(scene)
}

PlaygroundPage.current.liveView = sceneView
