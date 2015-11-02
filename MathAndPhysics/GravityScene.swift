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
}

private struct Speed {
  let x: CGFloat
  let y: CGFloat
  
  static let zero = Speed(x: 0, y: 0)
}

class GravityScene: SKScene {

  private var mario = SKSpriteNode(imageNamed: "mario")
  private var marioSpeed = Speed.zero
  private var marioSpeedDelta: CGFloat = 5
  
  override func didMoveToView(view: SKView) {
    backgroundColor = NSColor.whiteColor()
    
    setupMario()
    setupTerrain()
  }
  
  private func setupMario() {
    mario.setScale(0.5)
    mario.anchorPoint = CGPoint(x: 0.5, y: 0)
    mario.position = CGPoint(x: center.x, y: 60)
    addChild(mario)
  }
  
  private func setupTerrain() {
    let terrainTileRect = CGRect(x: 0, y: 0, width: 28, height: 30)
    let terrainTileRectPtr = UnsafeMutablePointer<CGRect>.alloc(1)
    terrainTileRectPtr.memory = terrainTileRect
    let terrainImage = NSImage(named: "terrain")?.CGImageForProposedRect(terrainTileRectPtr, context: nil, hints: nil)
    let coverageSize = CGSize(width: size.width, height: 60)
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
    switch Int(theEvent.keyCode)
    {
    case KeyCode.left:
      marioSpeed = Speed(x: -marioSpeedDelta, y: 0)
      
    case KeyCode.right:
      marioSpeed = Speed(x: marioSpeedDelta, y: 0)
      
    default:
      break
    }
  }
  
  override func keyUp(theEvent: NSEvent) {
    marioSpeed = Speed.zero
  }
  
  override func update(currentTime: NSTimeInterval) {
    var resultPosition = mario.position
    resultPosition.x += marioSpeed.x
    
    guard resultPosition.x > 0 && resultPosition.x < size.width else {
      return
    }
    
    mario.position = resultPosition
  }
  
}
