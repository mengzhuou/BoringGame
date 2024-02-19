//
//  GameScene.swift
//  BoringGame
//
//  Created by Mengzhu Ou on 2/18/24.
//

import SpriteKit

class GameScene: SKScene{
    let brick = SKSpriteNode()
    var clickCount = 0
    var bounds: CGRect = CGRect.zero
    var countLabel = SKLabelNode()
    
    override func didMove(to view: SKView) {
        brick.size = CGSize(width: 100, height: 50)
        
        let brickSize = brick.size
        brick.position = CGPoint(x: 200, y: 50)
        
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
        
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -4.0)
        
        addChild(brick)
        createGround()
    }
    
    func createGround(){
        let ground = SKSpriteNode()
        ground.size = CGSize(width: 500, height: 5)
        ground.color = .clear
        ground.position = CGPoint(x: 250, y: 20)
        
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.affectedByGravity = false
        
        self.addChild(ground)
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
//            if brick.contains(location){
//                jump()
//            }
            
            let move = SKAction.move(to: location, duration: 0.1)
            brick.run(move)
        }
    }
    
    func jump(){
        brick.physicsBody?.applyImpulse(CGVector(dx: Int.random(in: -20...20), dy: 20))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
                        
            if brick.contains(location){
                clickCount += 1
                //update count
                countLabel.text = "Count: \(clickCount)"
                
                
            }
            
            brick.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
            brick.physicsBody?.isDynamic = true
            brick.physicsBody?.affectedByGravity = true
            
            
        }
    }
}


