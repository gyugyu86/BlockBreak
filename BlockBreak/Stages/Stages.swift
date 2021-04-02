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
        Variables.scene.physicsWorld.speed = 0.2
        // Stages 인스턴스 생성시 마다 bg 함수를 실행
        bg()
        paddleImage()
        ballImage()
        border()
        blocks()
        bottomImage()
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
        // 공의 속도 조절
        Variables.ball.physicsBody?.linearDamping = 0
        
    }
    
    // 바닥 설정
    func bottomImage() {
        let bottom = SKSpriteNode()
        bottom.size = CGSize(width: view.frame.width, height: 10)
        bottom.position = CGPoint(x: 0, y: -view.frame.height / 2)
        Variables.scene.addChild(bottom)
        bottom.physicsBody = SKPhysicsBody(rectangleOf: bottom.size)
        bottom.physicsBody?.isDynamic = false
        bottom.physicsBody?.affectedByGravity = false
        bottom.physicsBody?.allowsRotation = false
        bottom.physicsBody?.categoryBitMask = Variables.bottommCategory
        bottom.physicsBody?.contactTestBitMask = Variables.ballCategory
    }
    
    // ball이 사라지지 않게 경계를 선언(핸드폰 경계)
    func border() {
        let border = SKPhysicsBody(edgeLoopFrom: Variables.scene.frame)
        border.friction = 0
        border.restitution = 1
        Variables.scene.physicsBody = border
    }
    
    func blocks() {
        // 가로 10개, 세로 3개 총 30개의 블럭을 만들고, 각 블럭당 갭은 30으로 설정
        let col = 10
        let row = 3
        let gab = 30
        // 화면의 총 넓이를 10개의 블럭으로 나누기 위한 작업
        let block_w = Int(view.frame.width) / col
        let block_h = Int(block_w / 2) + gab
        
        // block의 시작점 지정
        let startX = Int(-view.frame.width / 2) + ( block_w + gab )
        let startY = Int(view.frame.height / 2) - ( block_h / 2 )
        
        for i in 0..<col {
            for j in 0..<row {
                let block = SKSpriteNode()
                block.size = CGSize(width: block_w, height: block_h)
                let xValue = (block_w - gab / 2) * i
                let yValue = (block_h - gab) * j
                block.position = CGPoint(x: startX + xValue, y: startY  - yValue)
                // 1 ~ 10 중에서 랜덤으로 num에 대입
                let num = Int.random(in: 1...8)
                block.texture = SKTexture(imageNamed: "block\(num)")
                block.zPosition = 1
                block.name = "block\(num)"
                // 화면에 블럭을 표시하기
                Variables.scene.addChild(block)
                // 블럭에 번호를 붙여 두기
                Variables.blockNum += 1
                block.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: block_w, height: block_h - (gab / 2)))
                block.physicsBody?.isDynamic = false
                block.physicsBody?.affectedByGravity = false
                block.physicsBody?.allowsRotation = false
                block.physicsBody?.categoryBitMask = Variables.blockCategory
                block.physicsBody?.contactTestBitMask = Variables.ballCategory
            }
        }
    }
}
