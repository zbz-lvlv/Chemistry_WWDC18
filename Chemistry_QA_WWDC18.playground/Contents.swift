//: A SpriteKit based Playground
import PlaygroundSupport
import SpriteKit
import AVFoundation

// Load the SKScene from 'GameScene_Tutorial.sks'
let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 760, height: 570))
if let scene = GameScene_Tutorial(fileNamed: "GameScene_Tutorial.sks") {
    // Set the scale mode to scale to fit the window
    scene.scaleMode = .resizeFill
    
    // Present the scene
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView

//Play sound

var backgroundAP: AVAudioPlayer?

let path = Bundle.main.path(forResource: "background_music.mp3", ofType:nil)!
let url = URL(fileURLWithPath: path)

do {
    backgroundAP = try AVAudioPlayer(contentsOf: url)
    backgroundAP?.volume = 0.05;
    backgroundAP?.numberOfLoops = 10;
    backgroundAP?.play()
} catch {
    print("Error with playing background music")
}
