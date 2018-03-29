import Foundation
import SpriteKit

public class GameScene_Anion : SKScene{
    
    //Background
    let spriteNodeBackground = SKSpriteNode(imageNamed: "background_anion.png")
    
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
    var bottleHeld: SKSpriteNode!
    var isHoldingBottle = false;
    var reagentUsed = Reagent.none;
    var reagentUsedString = ""
    var ionUsed = Ion.none
    
    //Ions
    var ionTestTubes: [SKSpriteNode] = []
    
    //Solution on platform
    var solutionOnPlatform: SKSpriteNode!
    var precipitatesInSolution: [SKShapeNode] = []
    var precipitated = false;
    
    //Stage
    //0 - Before selecting ions
    //1 - After selecting ions
    //2 - After adding reagents
    //3 - After adding excess reagents
    var stage = 0;
    
    //Arrow
    var arrow: SKSpriteNode!
    
    override public func didMove(to view: SKView) {
        
        spriteNodeBackground.position = CGPoint(x: 760 / 2, y: 570 / 2)
        spriteNodeBackground.size = CGSize(width: 760, height: 570)
        spriteNodeBackground.zPosition = -2;
        self.addChild(spriteNodeBackground)
        
        initUI()
        
        displayWelcomeText();
        
    }
    
    /* UI Begin */
    public func initUI(){
        
        generateGuidingText()
        generateMenuButtons()
        generateAnions()
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
        
        let menuTitles = ["Tutorial", "Positive ions", "Negative ions", "Try-it-out"]
        
        let nonSelectedColor = UIColor(red: 112/255, green: 48/255, blue: 160/255, alpha: 1)
        let selectedColor = UIColor(red: 255/255, green: 240/255, blue: 255/255, alpha: 1)
        
        let nonSelectedColorFont = UIColor(red: 255/255, green: 240/255, blue: 255/255, alpha: 1)
        let selectedColorFont = UIColor(red: 200/255, green: 0/255, blue: 0/255, alpha: 1)
        
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
            shapeNode.position = CGPoint(x: 6, y: 520 - i * 50)
            shapeNode.addChild(labelNode)
            
            menuItems.append(shapeNode)
            self.addChild(shapeNode)
            
            if(i == 2){ //0 for tutorial option. 1 for cations. 2 for anions. 3 for try it out
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
    
    public func generateAnions(){
        
        let anionImages = ["so4.png", "cl.png", "br.png", "i.png"]
        
        var i = 0
        for anionImage in anionImages{
            
            let spriteNode = SKSpriteNode(imageNamed: anionImage)
            spriteNode.size = CGSize(width: 60, height: 150)
            spriteNode.position = CGPoint(x: 195 + i * 123, y: 135)
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
    
    /*begin*/
    
    public func displayWelcomeText(){
        
        let welcomeText =
            ["Here are more solutions with ions you can experiment with.",
             "You can also select positive ions in the menu bar on the left",
             " to experiment with them, or test your knowledge in",
             "'try-it-out' once you're ready."]
        
        editingGuidingText(linesIn: welcomeText)
        
        buttonNext.isHidden = true;
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
    
    public func displayPromptToPourReagent(reagent: SKSpriteNode){
        
        reagent.removeAllActions()
        reagent.alpha = 1
        
        guard let bottle = reagent.copy() as? SKSpriteNode else { return }
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
    public func pourReagent(){
        
        arrow.removeFromParent();
        
        isHoldingBottle = false;
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
    
    public func touchDown(atPoint pos : CGPoint) {
        
        if(stage == 1){
            
            if(atPoint(pos) == nh3Bottle && !isHoldingBottle){
                displayPromptToPourReagent(reagent: nh3Bottle)
                reagentUsedString = "ammonia"
                reagentUsed = Reagent.ammonia
            }
            
            if(atPoint(pos) == agno3Bottle && !isHoldingBottle){
                displayPromptToPourReagent(reagent: agno3Bottle)
                reagentUsedString = "silver nitrate"
                reagentUsed = Reagent.silverNitrate
            }
            
            if(atPoint(pos) == bano32Bottle && !isHoldingBottle){
                displayPromptToPourReagent(reagent: bano32Bottle)
                reagentUsedString = "barium nitrate"
                reagentUsed = Reagent.bariumNitrate
            }
            
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
            
            //Test
        else if(atPoint(pos) == menuItems[3] || atPoint(pos) == menuItemLabels[3]){
            if let scene = GameScene_Tutorial(fileNamed: "GameScene_Tutorial.sks") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .resizeFill
                
                // Present the scene
                self.view!.presentScene(scene)
                
                return;
            }
        }
        
        switch stage{
        case 0:
            
            var i = 0
            while(i < 4){
                if(atPoint(pos) == ionTestTubes[i]){
                    stage = 1;
                    
                    if let _ = solutionOnPlatform {
                        solutionOnPlatform.removeFromParent();
                    }
                    
                    putSolutionOnPlatform(number: i)
                    ionUsed = getIonUsedFromIndex(index: i)
                    
                    //sulfate ions
                    if(i == 0){
                        let text = ["This solution reacts with barium nitrate"]
                        editingGuidingText(linesIn: text)
                    }
                        
                    //halide ions
                    else{
                        let text = ["This solution reacts with silver nitrate"]
                        editingGuidingText(linesIn: text)
                    }
                    
                }
                
                i += 1
            }
            
            break;
            
        case 1:
            
            if(isHoldingBottle){
                
                if(calculateDistance(x1: bottleHeld.position.x, y1: bottleHeld.position.y, x2: solutionOnPlatform.position.x, y2: solutionOnPlatform.position.y + solutionOnPlatform.size.height / 2) < 100){
                    
                    pourReagent();
                    
                    self.run(SKAction.sequence([SKAction.wait(forDuration: 1.5)]),completion: {() -> Void in
                        //Continue from here because need to wait for completion
                        
                        switch(self.reagentUsed){
                        case .bariumNitrate:
                            
                            switch(self.ionUsed){
                            case .so4:
                                self.formPrecipitate(color: UIColor(red: 1, green: 1, blue: 1, alpha: 1))
                                
                                let text = ["Same white solid(precipitate) has formed!",
                                            "There is no need to add excess barium nitrate.",
                                             "You can click on another solution below to try it out."]
                                self.editingGuidingText(linesIn: text)
                                self.stage = 0;
                                
                                break;
                                
                            default:
                                break;
                            }
                            
                            break;
                            
                        case .silverNitrate:
                            
                            switch(self.ionUsed){
                            case .cl:
                                self.formPrecipitate(color: UIColor(red: 1, green: 1, blue: 1, alpha: 1))
                                
                                let text = ["Same white solid(precipitate) has formed!",
                                            "There is no need to add excess silver nitrate.",
                                            "You can click on another solution below to try it out."]
                                self.editingGuidingText(linesIn: text)
                                self.stage = 0;
                                
                                break;
                                
                            case .br:
                                self.formPrecipitate(color: UIColor(red: 1, green: 1, blue: 0.7, alpha: 1))
                                
                                let text = ["Same light-yellow solid(precipitate) has formed!",
                                            "There is no need to add excess silver nitrate.",
                                            "You can click on another solution below to try it out."]
                                self.editingGuidingText(linesIn: text)
                                self.stage = 0;
                                
                                break;
                                
                            case .i:
                                self.formPrecipitate(color: UIColor(red: 1, green: 0.8, blue: 0, alpha: 1))
                                
                                let text = ["Same yellow solid(precipitate) has formed!",
                                            "There is no need to add excess silver nitrate.",
                                            "You can click on another solution below to try it out."]
                                self.editingGuidingText(linesIn: text)
                                self.stage = 0;
                                
                                break;
                                
                            default:
                                break;
                            }
                            
                            break;
                            
                        default:
                            break;
                            
                        }
                        
                    })
                    
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
    
    public func getIonUsedFromIndex(index: Int) -> Ion{
        
        switch(index){
        case 0:
            return Ion.so4
        case 1:
            return Ion.cl
        case 2:
            return Ion.br
        case 3:
            return Ion.i
        default:
            return Ion.none
        }
        
    }
    
}
