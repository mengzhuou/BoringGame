//
//  GameScene.swift
//  BoringGame
//
//  Created by Mengzhu Ou on 2/18/24.
//

import SpriteKit

class GameScene: SKScene{
    let brick = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        brick.size = CGSize(width: 100, height: 50)
        
        let brickSize = CGSize(width: 100, height: 50)
        brick.position = CGPoint(x: 200, y: 100)
        
        
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
            
            let move = SKAction.move(to: location, duration: 0.1)
            brick.run(move)
            
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            brick.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
            brick.physicsBody?.isDynamic = true
            brick.physicsBody?.affectedByGravity = true
            
            
        }
    }
}


