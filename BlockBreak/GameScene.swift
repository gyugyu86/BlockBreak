//
//  GameScene.swift
//  BlockBreak
//
//  Created by 陰寅圭 on 2021/03/28.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        let bg = SKSpriteNode()
        bg.color = .red
        bg.size = CGSize(width:100, height: 100)
        bg.position = CGPoint(x: 0, y: 0)
        addChild(bg)
   
    }
    
    
}
