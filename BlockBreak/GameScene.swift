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
        Variables.scene = self
        setting()
    }
    
    
}
