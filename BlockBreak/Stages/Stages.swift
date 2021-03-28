//
//  Stages.swift
//  BlockBreak
//
//  Created by 陰寅圭 on 2021/03/28.
//

import Foundation
import SpriteKit

class Stages {
    
    init() {
        // Stages 인스턴스 생성시 마다 bg 함수를 실행
        bg()
    }
    
    // background image관련 수정
    func bg() {
        let view = Variables.scene.view!
        let bg = SKSpriteNode()
        bg.texture = SKTexture(imageNamed: "bg1")
        bg.size = view.frame.size
        bg.position = CGPoint(x: 0, y: 0)
        bg.zPosition = -1
        Variables.scene.addChild(bg)
        
    }
}
