//
//  Variables.swift
//  BlockBreak
//  모든 곳에서 사용 가능한 글로벌 변수들을 생성
//  Created by 陰寅圭 on 2021/03/28.
//

import Foundation
import SpriteKit

struct Variables {
    static var scene = SKScene()
    static var paddle = SKSpriteNode()
    static var ball = SKShapeNode(circleOfRadius: 10)
    
    // 각 카테고리 별로 고유의 값 지정하기
    static let ballCategory : UInt32 = 0x1 << 0     // 000xxxx1
    static let paddleCategory : UInt32 = 0x1 << 1   // 000xxx10
    static let bottommCategory : UInt32 = 0x1 << 2  // 000xx100
    static let blockCategory : UInt32 = 0x1 << 3    // 000x1000
    
}
