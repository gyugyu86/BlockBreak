//
//  Stages.swift
//  BlockBreak
//
//  Created by 陰寅圭 on 2021/03/28.
//

import Foundation
import SpriteKit

class Stages {
    let view = Variables.scene.view!
    
    init() {
        // Stages 인스턴스 생성시 마다 bg 함수를 실행
        bg()
        paddleImage()
        ballImage()
        border()
        
    }
    
    // background image관련 수정
    func bg() {
        let bg = SKSpriteNode()
        bg.texture = SKTexture(imageNamed: "bg1")
        bg.size = view.frame.size
        bg.position = CGPoint(x: 0, y: 0)
        bg.zPosition = -1
        Variables.scene.addChild(bg)
    }
    
    // paddle만들기
    func paddleImage() {
        Variables.paddle.size = CGSize(width: 200, height: 60)
        // 화면의 바닥의 위치에서 위로 30만큼 해당하는 부분에 paddle을 작성
        Variables.paddle.position = CGPoint(x: 0, y: -view.frame.height / 2 + 30)
        Variables.paddle.texture = SKTexture(imageNamed: "bar")
        Variables.paddle.zPosition = 2
        Variables.paddle.name = "paddle"
        Variables.scene.addChild(Variables.paddle)
        Variables.paddle.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 200, height: 45))
        // isDynamic = false 공이 떨어져 사라지지 않게 하기 위함
        Variables.paddle.physicsBody?.isDynamic = false
        Variables.paddle.physicsBody?.allowsRotation = false
        Variables.paddle.physicsBody?.affectedByGravity = false
        Variables.paddle.physicsBody?.friction = 0
        // restitution 튕기는 값
        Variables.paddle.physicsBody?.restitution = 0
        Variables.paddle.physicsBody?.categoryBitMask = Variables.paddleCategory
        Variables.paddle.physicsBody?.contactTestBitMask = Variables.ballCategory
    }
    
    // ball 만들기
    func ballImage() {
        Variables.ball.fillColor = .cyan
        Variables.ball.strokeColor = .green
        Variables.ball.glowWidth = 3
        Variables.ball.blendMode = .screen
        Variables.ball.position = CGPoint(x: Variables.paddle.position.x, y: Variables.paddle.position.y + 30)
        Variables.ball.name = "ball"
        Variables.scene.addChild(Variables.ball)
        Variables.ball.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        Variables.ball.physicsBody?.isDynamic = true
        Variables.ball.physicsBody?.affectedByGravity = false
        Variables.ball.physicsBody?.friction = 0
        Variables.ball.physicsBody?.restitution = 1
        Variables.ball.physicsBody?.categoryBitMask = Variables.ballCategory
        Variables.ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
        
    }
    
    // ball이 사라지지 않게 경계를 선언
    func border() {
        let border = SKPhysicsBody(edgeLoopFrom: Variables.scene.frame)
        border.friction = 0
        border.restitution = 1
        Variables.scene.physicsBody = border
    }
}
