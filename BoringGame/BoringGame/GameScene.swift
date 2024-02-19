//
//  GameScene.swift
//  BoringGame
//
//  Created by Mengzhu Ou on 2/18/24.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    let brick = SKSpriteNode()
    let ground = SKSpriteNode()
    var clickCount = 0
    var bounds: CGRect = CGRect.zero
    var countLabel = SKLabelNode()
    var startTouch = CGPoint()
    var endTouch = CGPoint()
    
    override func didMove(to view: SKView) {
        brick.size = CGSize(width: 100, height: 50)
        
        let brickSize = brick.size
        brick.position = CGPoint(x: 200, y: 50)
        
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -4.0)
        brick.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
        brick.physicsBody!.isDynamic = true
        brick.physicsBody!.affectedByGravity = true
        
        
        //contact with ground
        physicsWorld.contactDelegate = self
        brick.physicsBody?.categoryBitMask = 2
        brick.physicsBody?.contactTestBitMask = 2
        
        
        //body rectangle
        let bodyRect = CGRect(origin: CGPoint(x: -brickSize.width/2, y: -brickSize.height/2), size: brickSize)
        
        let bodyShape = SKShapeNode(rect: bodyRect, cornerRadius: 5)
        bodyShape.fillColor = .clear
        
        
        //border of rectangle
        let borderRect = CGRect(origin: CGPoint(x: -brickSize.width/2, y: -brickSize.height/2), size: brickSize)
        
        let borderShape = SKShapeNode(rect: borderRect, cornerRadius: 5)
        borderShape.strokeColor = .black
        borderShape.lineWidth = 2
        
        brick.addChild(bodyShape)
        brick.addChild(borderShape)
        
        //text of brick
        let brickText = SKLabelNode(text: "Boring")
        brickText.fontColor = .black
        brickText.fontSize = 23
        brickText.fontName = "Arial-BoldMT"
        brickText.position = CGPoint(x: 0, y: -7)
        
        brick.addChild(brickText)
        
        //count label
        countLabel = SKLabelNode(text: "Count: \(clickCount)")
        countLabel.fontColor = .black
        countLabel.fontSize = 25
        countLabel.fontName = "Arial-BoldMT"
        countLabel.horizontalAlignmentMode = .right
        countLabel.verticalAlignmentMode = .top
        countLabel.position = CGPoint(x: size.width - 50, y: size.height - 80)
        addChild(countLabel)
        
        
        //screen boundaries
        bounds = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height)
        let borderBody = SKPhysicsBody(edgeLoopFrom: bounds)
        self.physicsBody = borderBody
        
        addChild(brick)
        createGround()
    }
    
    func createGround(){
        ground.physicsBody?.categoryBitMask = 1
        ground.physicsBody?.contactTestBitMask = 1
        ground.size = CGSize(width: 500, height: 5)
        ground.color = .clear
        ground.position = CGPoint(x: 250, y: 20)
        
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.affectedByGravity = false
        
        self.addChild(ground)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if brick.contains(location) {
                startTouch = location
                clickCount += 1
                countLabel.text = "Count: \(clickCount)"
                
                let impulseX = startTouch.x
                let impulseY = startTouch.y
                let randomDX = CGFloat(Int.random(in: -500...0))
                let randomDY = CGFloat(Int.random(in: 15...50))
                
                brick.physicsBody?.applyImpulse(CGVector(dx: impulseX + randomDX, dy: impulseY + randomDY))
            }
        }
        
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            endTouch = touch.location(in: self)
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if (contact.bodyA.node == brick && contact.bodyB.node == ground) || (contact.bodyB.node == brick && contact.bodyA.node == ground) {
            clickCount = 0
            countLabel.text = "Count: \(clickCount)"
        }
    }
}


