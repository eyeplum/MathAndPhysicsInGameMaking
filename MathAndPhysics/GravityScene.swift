//
//  GravityScene.swift
//  MathAndPhysics
//
//  Created by Yan Li on 11/2/15.
//  Copyright © 2015 eyeplum. All rights reserved.
//

import SpriteKit

struct KeyCode {
  static let left = 123
  static let right = 124
  static let down = 125
  static let up = 126
  static let space = 49
}

private struct Speed {
  var x: CGFloat
  var y: CGFloat
  
  static let zero = Speed(x: 0, y: 0)
}

class GravityScene: SKScene {

  private var mario = SKSpriteNode(imageNamed: "mario")
  private var marioSpeed = Speed.zero
  private var jumpping = false
  
  private struct Constant {
    static let speedDelta: CGFloat = 5
    static let terrainHeight: CGFloat = 60
    static let jumpDelta: CGFloat = 85
  }
  
  override func didMoveToView(view: SKView) {
    backgroundColor = NSColor.whiteColor()
    
    setupMario()
    setupTerrain()
  }
  
  private func setupMario() {
    mario.setScale(0.5)
    mario.anchorPoint = CGPoint(x: 0.5, y: 0)
    mario.position = CGPoint(x: center.x, y: Constant.terrainHeight)
    addChild(mario)
  }
  
  private func setupTerrain() {
    let terrainTileRect = CGRect(x: 0, y: 0, width: 28, height: 30)
    let terrainTileRectPtr = UnsafeMutablePointer<CGRect>.alloc(1)
    terrainTileRectPtr.memory = terrainTileRect
    let terrainImage = NSImage(named: "terrain")?.CGImageForProposedRect(terrainTileRectPtr, context: nil, hints: nil)
    let coverageSize = CGSize(width: size.width, height: Constant.terrainHeight)
    let image = NSImage(size: coverageSize)
    image.lockFocus()
    let context = NSGraphicsContext.currentContext()?.CGContext
    CGContextDrawTiledImage(context, terrainTileRect, terrainImage)
    image.unlockFocus()
    
    let terrainTexure = SKTexture(image: image)
    let terrainNode = SKSpriteNode(texture: terrainTexure)
    terrainNode.anchorPoint = CGPoint.zero
    terrainNode.position = CGPoint.zero
    addChild(terrainNode)
  }
  
  override func keyDown(theEvent: NSEvent) {
    switch Int(theEvent.keyCode) {
    case KeyCode.left:
      marioSpeed.x = -Constant.speedDelta
      
    case KeyCode.right:
      marioSpeed.x = Constant.speedDelta
      
    case KeyCode.space:
      guard !jumpping else {
        break
      }
      jumpping = true
      marioSpeed.y = Constant.speedDelta
      
    default:
      break
    }
  }
  
  override func keyUp(theEvent: NSEvent) {
    switch Int(theEvent.keyCode) {
    case KeyCode.left, KeyCode.right:
      marioSpeed.x = 0
      
    default:
      break
    }
  }
  
  override func update(currentTime: NSTimeInterval) {
    var resultPosition = mario.position
    resultPosition.x += marioSpeed.x
    resultPosition.y += marioSpeed.y
    
    // Horizontal Moving
    if !(resultPosition.x > 0 && resultPosition.x < size.width) {
      resultPosition.x = mario.position.x
    }
    
    // Vertical Moving
    if resultPosition.y >= (Constant.terrainHeight + Constant.jumpDelta) {
      resultPosition.y = mario.position.y
      marioSpeed.y = -Constant.speedDelta
    }
    
    if resultPosition.y <= Constant.terrainHeight {
      resultPosition.y = Constant.terrainHeight
      marioSpeed.y = 0
      jumpping = false
    }
    
    mario.position = resultPosition
  }
  
}
