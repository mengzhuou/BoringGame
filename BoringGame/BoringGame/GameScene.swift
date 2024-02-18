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
        
        brick.size = CGSize(width: 80, height: 50)
        brick.position = CGPoint(x: 100, y: 100)
        brick.color = .black
        
        
        let brickText = SKLabelNode(text: "Boring")
        brickText.color = .black
        brickText.fontSize = 18
        brickText.fontName = "Arial-BoldMT"
        brickText.position = CGPoint(x: 0, y: 0)
        brick.addChild(brickText)
        
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -1.0)
        
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


