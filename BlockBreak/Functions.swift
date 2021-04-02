//
//  Functions.swift
//  BlockBreak
//  모든 기능들을 이곳에서 관리
//  Created by 陰寅圭 on 2021/03/28.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func setting() {
        // Stages 인스턴스 생성
        let stage = Stages()
    }
    
    // 처음 터치 했을때
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            // 화면에서 터치한 정보가 location에 설정
            let location = touch.location(in: self)
            let node : SKNode = self.atPoint(location)
            if Variables.isPlayed {
                Variables.paddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
            } else {
                Variables.paddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
                Variables.ball.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
            
            if node.name == "restart" {
                restart()
            }
            
        }
    }
    
    // 터치 한 상태에서 움직일때(드래그)
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            // 화면에서 터치한 정보가 location에 설정
            let location = touch.location(in: self)
            if Variables.isPlayed {
                Variables.paddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
            } else {
                Variables.paddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
                Variables.ball.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
            
        }
    }
    
    // touch가 끝났을때
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            // 현재 클릭 한 곳에 노드가 생성됨
            let node : SKNode = self.atPoint(location)
            if node.name == "paddle" {
                if !Variables.isPlayed {
                    Variables.isPlayed = true
                    Variables.ball.physicsBody?.isDynamic = true
                    Variables.ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
                }
            }
        }
    }
    
    // physicsbody가 어떤 physicsbody에 닿았는지 체크하는 함수
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // 공이 바닥에 닿았을 경우
        if firstBody.categoryBitMask == Variables.ballCategory && secondBody.categoryBitMask == Variables.bottommCategory {
            // 게임 오버
            gameOver()
            firstBody.node?.run(SKAction.playSoundFileNamed("gameOver.wav", waitForCompletion: false))
        }
        
        // 공이 블럭에 닿았을 경우
        if firstBody.categoryBitMask == Variables.ballCategory && secondBody.categoryBitMask == Variables.blockCategory {
            // 효과음 처림
            let num : String = String(secondBody.node!.name!.last!)
            let soundName = "sound\(num).wav"
            firstBody.node!.run(SKAction.playSoundFileNamed(soundName, waitForCompletion: false))
            
            // 블럭 제거 효과
            emitter(blockName: secondBody.node!.name!, point: secondBody.node!.position)
            
            // 블럭 제거
            secondBody.node?.removeFromParent()
            
            // 블럭 제거 카운트
            Variables.blockNum -= 1
            
            if Variables.blockNum == 0 {
                // Game Clear
                print("Game Clear")
                // 다음 스테이지 이동
                
            }
        }
        
        // 공이 패들에 닿았을 경우
        if firstBody.categoryBitMask == Variables.ballCategory && secondBody.categoryBitMask == Variables.paddleCategory {
            // 효과음 처리
            firstBody.node?.run(SKAction.playSoundFileNamed("paddle.wav", waitForCompletion: false))
        }
        
    }
    
    // 공이 바닥에 떨어 졌을때 Game Over
    func gameOver() {
        let view = Variables.scene.view!
        let bg = SKSpriteNode()
        bg.color = .black
        bg.alpha = 0.8
        bg.zPosition = 10
        bg.name = "gameoverBG"
        bg.position = CGPoint(x: 0, y: 0)
        bg.size = view.frame.size
        Variables.scene.addChild(bg)
        
        let gameOverText = SKLabelNode()
        gameOverText.fontName = "Courier-Bold"
        gameOverText.fontSize = 100
        gameOverText.text = "Game Over"
        gameOverText.position = CGPoint(x: 0, y: 0)
        gameOverText.color = .white
        gameOverText.zPosition = 11
        gameOverText.alpha = 0
        bg.addChild(gameOverText)
        
        let btn = SKSpriteNode()
        btn.size = CGSize(width: 150, height: 50)
        btn.texture = SKTexture(imageNamed: "restart_btn")
        btn.position = CGPoint(x: 0, y: -80)
        btn.zPosition = 11
        btn.name = "restart"
        bg.addChild(btn)
        
        let action = SKAction.fadeIn(withDuration: 0.1)
        gameOverText.run(action){
            view.isPaused = true
        }
        
    }
    
    // Game Restart
    func restart() {
        
        if let bg = Variables.scene.childNode(withName: "gameoverBG"){
            bg.removeFromParent()
            Variables.isPlayed = false
            Variables.scene.view?.isPaused = false
            Variables.ball.position = CGPoint(x: Variables.paddle.position.x, y: Variables.paddle.position.y + 30)
            Variables.ball.physicsBody?.isDynamic = false
            
        }
    }
    
    // 블럭 제거 효과 주기
    func emitter(blockName : String, point : CGPoint) {
        let emit = SKEmitterNode(fileNamed: "Explosion.sks")
        emit?.particleTexture = SKTexture(imageNamed: blockName)
        emit?.position = point
        emit?.zPosition = 2
        Variables.scene.addChild(emit!)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            emit?.removeFromParent()
            emit?.removeAllActions()
        }
    }
    
}
