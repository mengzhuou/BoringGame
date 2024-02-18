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
        
        brick.size = CGSize(width: 50, height: 50)
        brick.position = CGPoint(x: 100, y: 100)
        brick.color = .blue
        
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -1.0)
        
        addChild(brick)
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for touch in touches {
//            let location = touch.location(in: self)
////            brick.position = location
//            
//            let action = SKAction.move(to: location, duration: 1.0)
//            brick.run(action)
//            
//            
//        }
//    }
    
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


