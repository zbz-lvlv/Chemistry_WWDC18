import Foundation
import SpriteKit

public class GameScene_Tutorial : SKScene{
    
    //Background
    let spriteNodeBackground = SKSpriteNode(imageNamed: "background_tutorial_cation.png")
    
    //Menu items
    var menuItems: [SKShapeNode] = []
    var menuItemLabels: [SKLabelNode] = []
    
    //Guiding texts
    var labelNodesGuidingText: [SKLabelNode] = []
    var buttonNext: SKShapeNode!
    var buttonNextLabel: SKLabelNode!
    
    //Reagents:
    var nh3Bottle: SKSpriteNode!
    var bano32Bottle: SKSpriteNode!
    var agno3Bottle: SKSpriteNode!
    var bottleHeld = SKSpriteNode()
    var isHoldingBottle = false;
    
    //Ions
    var ionTestTubes: [SKSpriteNode] = []
    
    //Solution on platform
    var solutionOnPlatform: SKSpriteNode!
    var precipitatesInSolution: [SKShapeNode] = []
    
    //Arrow
    var arrow: SKSpriteNode!
    
    //Stage
    /*
     Stage 0: Welcome
     Stage 1: Pickup copper test tube
     Stage 2: Pick up ammonia and pouring it in
     Stage 3: Pick up excess ammonia and pouring it in
     */
    var stage = 0;
    
    override public func didMove(to view: SKView) {
        
        self.run(SKAction.playSoundFileNamed("tap.wav", waitForCompletion: false))
        
        spriteNodeBackground.position = CGPoint(x: 760 / 2, y: 570 / 2)
        spriteNodeBackground.size = CGSize(width: 760, height: 570)
        spriteNodeBackground.zPosition = -2;
        self.addChild(spriteNodeBackground)
        
        initUI()
        
        startTutorial()
        
    }
    
    /* UI Begin */
    public func initUI(){
        
        generateGuidingText()
        generateMenuButtons()
        generateCations()
        generateReagentBottles()
        
    }
    
    public func generateGuidingText(){
        
        var i = 0
        while i < 4 {
            
            let labelNode = SKLabelNode(fontNamed: "Futura")
            labelNode.text = ""
            labelNode.fontSize = 15
            labelNode.fontColor = UIColor(red: 112/255, green: 48/255, blue: 160/255, alpha: 1)
            labelNode.position = CGPoint(x: 380, y: 537 - i * 22)
            labelNode.horizontalAlignmentMode = .center
            labelNode.verticalAlignmentMode = .center
            self.addChild(labelNode)
            labelNodesGuidingText.append(labelNode)
            
            i += 1
            
        }
        
        buttonNextLabel = SKLabelNode(fontNamed: "Futura")
        buttonNextLabel.text = "Next"
        buttonNextLabel.fontSize = 15
        buttonNextLabel.fontColor = UIColor(red: 200/255, green: 0/255, blue: 0/255, alpha: 1)
        buttonNextLabel.position = CGPoint(x: 18, y: 9)
        buttonNextLabel.horizontalAlignmentMode = .center
        buttonNextLabel.verticalAlignmentMode = .center
        
        buttonNext = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 36, height: 18), cornerRadius: 2)
        buttonNext.position = CGPoint(x: 563, y: 457)
        buttonNext.fillColor = UIColor(red: 255/255, green: 240/255, blue: 255/255, alpha: 1)
        buttonNext.strokeColor = UIColor(red: 200/255, green: 0/255, blue: 0/255, alpha: 1)
        buttonNext.addChild(buttonNextLabel);
        
        self.addChild(buttonNext)
        
    }
    
    public func editingGuidingText(linesIn: [String]){
        
        var lines = linesIn
        
        while (lines.count < 4) {
            lines.append("")
        }
        
        var i = 0
        for line in lines {
            
            labelNodesGuidingText[i].text = line
            i += 1
            
        }
        
    }
    
    public func generateMenuButtons(){
        
        let menuTitles = ["Tutorial", "Positive ions", "Negative ions"]
        
        let nonSelectedColor = UIColor(red: 112/255, green: 48/255, blue: 160/255, alpha: 1)
        let selectedColor = UIColor(red: 255/255, green: 240/255, blue: 255/255, alpha: 1)
        
        let nonSelectedColorFont = UIColor(red: 255/255, green: 240/255, blue: 255/255, alpha: 1)
        let selectedColorFont = UIColor(red: 200/255, green: 0/255, blue: 0/255, alpha: 1)
        
        let labelNode = SKLabelNode(fontNamed: "Futura")
        labelNode.text = "Menu Bar"
        labelNode.fontSize = 15
        labelNode.position = CGPoint(x: 50, y: 530)
        labelNode.horizontalAlignmentMode = .center
        labelNode.verticalAlignmentMode = .center
        labelNode.fontColor = nonSelectedColorFont
        self.addChild(labelNode)
        
        var i = 0
        for menuTitle in menuTitles{
            
            let labelNode = SKLabelNode(fontNamed: "Futura")
            labelNode.text = menuTitle
            labelNode.fontSize = 13
            labelNode.position = CGPoint(x: 85/2, y: 30/2)
            labelNode.horizontalAlignmentMode = .center
            labelNode.verticalAlignmentMode = .center
            menuItemLabels.append(labelNode)
            
            let shapeNode = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 85, height: 30), cornerRadius: 5)
            shapeNode.position = CGPoint(x: 6, y: 470 - i * 50)
            shapeNode.addChild(labelNode)
            
            menuItems.append(shapeNode)
            self.addChild(shapeNode)
            
            if(i == 0){ //0 for tutorial option. 1 for cations. 2 for anions. 3 for try it out
                labelNode.fontColor = selectedColorFont
                shapeNode.fillColor = selectedColor
            }
            else{
                labelNode.fontColor = nonSelectedColorFont
                shapeNode.fillColor = nonSelectedColor
            }
            
            i += 1
            
        }
        
    }
    
    public func generateCations(){
        
        let cationImages = ["cu_light.png", "fe2.png", "fe3.png", "zn.png", "al.png"]
        
        var i = 0
        for cationImage in cationImages{
            
            let spriteNode = SKSpriteNode(imageNamed: cationImage)
            spriteNode.size = CGSize(width: 60, height: 150)
            spriteNode.position = CGPoint(x: 134 + i * 123, y: 135)
            self.addChild(spriteNode)
            
            ionTestTubes.append(spriteNode)
            
            i += 1
            
        }
        
    }
    
    public func generateReagentBottles(){
        
        nh3Bottle = SKSpriteNode(imageNamed: "nh3.png")
        nh3Bottle.position = CGPoint(x: 50, y: 265)
        nh3Bottle.size = CGSize(width: 70, height: 157)
        self.addChild(nh3Bottle)
        
        bano32Bottle = SKSpriteNode(imageNamed: "bano32.png")
        bano32Bottle.position = CGPoint(x: 710, y: 483)
        bano32Bottle.size = CGSize(width: 70, height: 157)
        self.addChild(bano32Bottle)
        
        agno3Bottle = SKSpriteNode(imageNamed: "agno3.png")
        agno3Bottle.position = CGPoint(x: 710, y: 265)
        agno3Bottle.size = CGSize(width: 70, height: 157)
        self.addChild(agno3Bottle)
        
    }
    
    /*Tutorial begin*/
    public func startTutorial(){
        
        //Welcome the user
        displayWelcomeText()
        
    }
    
    public func displayWelcomeText(){
        
        let welcomeText =
        ["Welcome to the Qualitative Analysis Chemistry laboratory!",
         "Today we will be identifying chemical ions",
         "which are present in a solution."]
        
        editingGuidingText(linesIn: welcomeText)
        
    }
    
    public func displayPromptToPickUpCuSolution(){
        
        let text = ["To start off, click on the light blue copper(II) solution",
                    "that is blinking."]
        editingGuidingText(linesIn: text)
        
        //Get the copper test tube to blink. Index of Cu = 0
        ionTestTubes[0].run(SKAction.repeatForever(SKAction.sequence([.fadeOut(withDuration: 0.8), .fadeIn(withDuration: 0.8)])))
        
    }
    
    public func putSolutionOnPlatform(number: Int){
        
        //Put copper on platform
        ionTestTubes[number].removeAllActions();
        ionTestTubes[number].alpha = 1;
        
        guard let solution = ionTestTubes[number].copy() as? SKSpriteNode else { return }
        solutionOnPlatform = solution
        solutionOnPlatform.position = CGPoint(x: 380, y: 335)
        solutionOnPlatform.size = CGSize(width: 75, height: 180)
        self.addChild(solutionOnPlatform)
        
    }
    
    public func displayPromptToPickUpAmmonia(){
        
        //Prompt ammonia
        let text = ["Ammonia can be used to detect the presence of copper(II) ions.",
                    "Click and drag the blinking blue bottle of ammonia (NH3)",
                    "to the top of the test tube on the platform."]
        editingGuidingText(linesIn: text)
        
        //Get the copper test tube to blink. Index of Cu = 0
        nh3Bottle.run(SKAction.repeatForever(SKAction.sequence([.fadeOut(withDuration: 0.8), .fadeIn(withDuration: 0.8)])))
        
    }
    
    public func displayPromptToPourAmmonia(){
        
        nh3Bottle.removeAllActions()
        nh3Bottle.alpha = 1
        
        guard let bottle = nh3Bottle.copy() as? SKSpriteNode else { return }
        bottleHeld = bottle
        
        let newWidth = bottle.size.width / 2
        let newHeight = bottle.size.height / 2
        bottleHeld.size = CGSize(width: newWidth, height: newHeight)
        bottleHeld.zRotation = 3.1415926;
        
        self.addChild(bottleHeld)
        
        isHoldingBottle = true;
        
        arrow = SKSpriteNode(imageNamed: "arrow_down.png")
        arrow.position = CGPoint(x: 380, y: 470)
        arrow.size = CGSize(width: 25.2, height: 20.0)
        self.addChild(arrow)
        
        let down = SKAction.moveBy(x: 0, y: -10, duration: 0.5)
        let up = SKAction.moveBy(x: 0, y: 10, duration: 0.1)
        arrow.run(SKAction.repeatForever(SKAction.sequence([down, up])))
        
    }
    
    //takes 1.5 seconds
    public func pourAmmonia(){
        
        arrow.removeFromParent();
        
        self.run(SKAction.playSoundFileNamed("pour.wav", waitForCompletion: false))
        
        bottleHeld.position = CGPoint(x: 380, y: 460)

        //Animate flow of solution
        let solutionFlow = SKSpriteNode();
        solutionFlow.position = CGPoint(x: 380, y: 460)
        solutionFlow.anchorPoint = CGPoint(x: 0.5, y: 0)
        solutionFlow.size = CGSize(width: 10, height: 10)
        solutionFlow.color = UIColor(red: 1, green: 1, blue: 1, alpha: 0.75)
        solutionFlow.zPosition = -1;
        self.addChild(solutionFlow)
        
        let enlargeAction = SKAction.resize(byWidth: 0, height: -200, duration: 0.3)
        let wait = SKAction.wait(forDuration: 0.9)
        let fadeOut = SKAction.fadeOut(withDuration: 0.3)
        
        solutionFlow.run(SKAction.sequence([enlargeAction, wait, fadeOut]))
        
        let bottleWait = SKAction.wait(forDuration: 1.2)
        bottleHeld.run(SKAction.sequence([bottleWait, fadeOut]),completion: {() -> Void in
            self.bottleHeld.removeFromParent();
        })
        
    }
    
    public func formPrecipitate(color: UIColor){
        
        var i = 0
        while(i < 10){
        
            let pptNode = SKShapeNode(circleOfRadius: 5);
            pptNode.fillColor = color
            pptNode.strokeColor = UIColor.clear
            
            let x = Int(arc4random_uniform(26)) + 367
            let y = Int(arc4random_uniform(20)) + 256
            pptNode.position = CGPoint(x: x, y: y);
            
            precipitatesInSolution.append(pptNode)
            
            self.addChild(pptNode)
            
            i += 1
            
        }
        
    }
    
    public func removePrecipitate(){
        
        for ppt in precipitatesInSolution{
            ppt.removeFromParent();
        }
        
    }
    
    public func changeColor(newFileName: String){
        
        let newTexture = SKTexture(image: UIImage(named: newFileName)!)
        solutionOnPlatform.texture = newTexture
        
    }
    
    public func displayPromptToPourExcessAmmonia(){
        
        let text = ["Same blue solid(precipitate) has formed!",
                   "Let's see what happens if we keep",
                   "on adding ammonia (NH3)."]
        editingGuidingText(linesIn: text)
        
        nh3Bottle.run(SKAction.repeatForever(SKAction.sequence([.fadeOut(withDuration: 0.8), .fadeIn(withDuration: 0.8)])))
        
    }
    
    public func displayExcessResults(){
        
        let text = ["The blue solid disappeared and the solution turned dark blue!",
                    "If copper(II) ions are present, blue solid forms on",
                    "adding ammonia, and dissolves into a dark blue solution",
                    "with excess ammonia."]
        editingGuidingText(linesIn: text)
        
    }
    
    public func touchDown(atPoint pos : CGPoint) {
        
        switch stage{
            
        case 2:
            
            if(atPoint(pos) == nh3Bottle && !isHoldingBottle){
                self.run(SKAction.playSoundFileNamed("grab.wav", waitForCompletion: false))
                displayPromptToPourAmmonia()
            }
            
            break;
            
        case 3:
            
            if(atPoint(pos) == nh3Bottle && !isHoldingBottle){
                self.run(SKAction.playSoundFileNamed("grab.wav", waitForCompletion: false))
                displayPromptToPourAmmonia()
            }
            
            break;
            
        default:
            break;
        }
        
    }
    
    public func touchMoved(toPoint pos : CGPoint) {
        
        if(isHoldingBottle){
            bottleHeld.position = pos
        }
        
    }
    
    public func touchUp(atPoint pos : CGPoint) {
        
        //For menu bar navigation
        
        //Tutorial
        if(atPoint(pos) == menuItems[0] || atPoint(pos) == menuItemLabels[0]){
            if let scene = GameScene_Tutorial(fileNamed: "GameScene_Tutorial.sks") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .resizeFill
                
                // Present the scene
                self.view!.presentScene(scene)
                
                return;
            }
        }
            
        //Cation
        else if(atPoint(pos) == menuItems[1] || atPoint(pos) == menuItemLabels[1]){
            
            if let scene = GameScene_Cation(fileNamed: "GameScene_Cation.sks") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .resizeFill

                // Present the scene
                self.view!.presentScene(scene)
                
                return;
            }
        }
            
        //Anion
        else if(atPoint(pos) == menuItems[2] || atPoint(pos) == menuItemLabels[2]){
            if let scene = GameScene_Anion(fileNamed: "GameScene_Anion.sks") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .resizeFill
                
                // Present the scene
                self.view!.presentScene(scene)
                
                return;
            }
        }
        
        switch stage{
        case 0:
            
            if(atPoint(pos) == buttonNext || atPoint(pos) == buttonNextLabel){
                stage = 1;
                
                self.run(SKAction.playSoundFileNamed("tap.wav", waitForCompletion: false))
                
                displayPromptToPickUpCuSolution()
                buttonNext.isHidden = true;
            }
            
            break;
            
        case 1:
            
            if(atPoint(pos) == ionTestTubes[0]){
                stage = 2;
                
                self.run(SKAction.playSoundFileNamed("grab.wav", waitForCompletion: false))
                
                putSolutionOnPlatform(number: 0) //Number 0 implies copper(II)
                displayPromptToPickUpAmmonia()
            }
            
            break;
            
        case 2:
            
            if(isHoldingBottle && calculateDistance(x1: bottleHeld.position.x, y1: bottleHeld.position.y, x2: solutionOnPlatform.position.x, y2: solutionOnPlatform.position.y + solutionOnPlatform.size.height / 2) < 100){
                
                stage = 3;
                isHoldingBottle = false;
                
                pourAmmonia(); //Takes 1.5 seconds
                
                self.run(SKAction.sequence([SKAction.wait(forDuration: 1.5)]),completion: {() -> Void in
                    //Continue from here because need to wait for completion
                    self.displayPromptToPourExcessAmmonia();
                    
                    self.run(SKAction.playSoundFileNamed("success.wav", waitForCompletion: false))
                })
                
                //Cu2+ + 2OH- --> Cu(OH)2
                formPrecipitate(color: UIColor(red: 25/255, green: 143/255, blue: 1, alpha: 1))

            }
            
            break;
            
        case 3: //Excess ammonia -> Forms dark blue copper(II) complex
            
            if(isHoldingBottle && calculateDistance(x1: bottleHeld.position.x, y1: bottleHeld.position.y, x2: solutionOnPlatform.position.x, y2: solutionOnPlatform.position.y + solutionOnPlatform.size.height / 2) < 100){
                
                stage = 4
                
                pourAmmonia();
                
                self.run(SKAction.sequence([SKAction.wait(forDuration: 1.5)]),completion: {() -> Void in
                    
                    self.run(SKAction.playSoundFileNamed("success.wav", waitForCompletion: false))
                    
                    self.removePrecipitate();
                    self.changeColor(newFileName: "cu_dark.png");
                    self.displayExcessResults();
                    
                    self.run(SKAction.playSoundFileNamed("success.wav", waitForCompletion: false))
                    
                    self.buttonNext.isHidden = false;
                    
                })
                
            }
            
            break;
            
        case 4:
            
            //Tutorial done -> Start the thing
            if(atPoint(pos) == buttonNext || atPoint(pos) == buttonNextLabel){

                if let scene = GameScene_Cation(fileNamed: "GameScene_Cation.sks") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .resizeFill
                    
                    // Present the scene
                    self.view!.presentScene(scene)
                }
                
            }
            
            break;
            
        default:
            break;
        }
        
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchDown(atPoint: t.location(in: self)) }
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    
    override public func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
    }
    
    public func calculateDistance(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat) -> CGFloat{
        let square = (x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1)
        return sqrt(square)
    }
    
}
