//
//  MenuScene.swift
//  MathAndPhysics
//
//  Created by Yan Li on 11/1/15.
//  Copyright © 2015 eyeplum. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
  
  let container = SKNode()
  let moveButton = SKSpriteNode(imageNamed: "button_move")
  let gravityButton = SKSpriteNode(imageNamed: "button_gravity")
  
  override func didMoveToView(view: SKView) {
    container.addChild(moveButton)
    container.addChild(gravityButton)
    addChild(container)
    moveButton.position = CGPoint(x: 0, y: 50)
    gravityButton.position = CGPoint(x: 0, y: -50)
  }

  override func update(currentTime: NSTimeInterval) {
    container.position = center
  }
  
  override func mouseMoved(theEvent: NSEvent) {
    print(theEvent.locationInNode(self))
  }
  
}
