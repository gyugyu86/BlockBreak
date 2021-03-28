//
//  GameViewController.swift
//  BlockBreak
//
//  Created by 陰寅圭 on 2021/03/28.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            let scene = GameScene(size: view.frame.size)
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                // anchorPoint 기준점을 핸드폰 정 중앙으로 잡기
                scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                // Present the scene
                view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
