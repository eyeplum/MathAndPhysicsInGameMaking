//
//  GameScene.swift
//  MathAndPhysics
//
//  Created by Yan Li on 10/31/15.
//  Copyright (c) 2015 eyeplum. All rights reserved.
//

import SpriteKit

class MoveScene: SKScene {
  
  private var sprite = SKSpriteNode(imageNamed: Const.Asset.spaceship)
  private var spriteSpeed = Speed(x: 0, y: 0)

  private var bullet = SKSpriteNode(imageNamed: Const.Asset.bullet)
  private var currentTrack = Track(radius: 0, angle: 0)
  private let deltaTrack = Track(radius: 0.02, angle: π/120)
  
  override func didMoveToView(view: SKView) {
    sprite.position = center
    sprite.setScale(Const.Logic.spaceshipInitialScale)
    addChild(sprite)
    
    bullet.position = center
    addChild(bullet)
  }
  
  override func keyDown(theEvent: NSEvent) {
    switch Int(theEvent.keyCode)
    {
    case Const.KeyCode.left:
      spriteSpeed = Speed(x: -Const.Logic.speed, y: spriteSpeed.y)
      
    case Const.KeyCode.right:
      spriteSpeed = Speed(x: Const.Logic.speed, y: spriteSpeed.y)
      
    case Const.KeyCode.down:
      spriteSpeed = Speed(x: spriteSpeed.x, y: -Const.Logic.speed)
    
    case Const.KeyCode.up:
      spriteSpeed = Speed(x: spriteSpeed.x, y: Const.Logic.speed)

    default:
      break
    }
  }
  
  override func keyUp(theEvent: NSEvent) {
    switch Int(theEvent.keyCode)
    {
    case Const.KeyCode.left:
      spriteSpeed = Speed(x: 0, y: spriteSpeed.y)
      
    case Const.KeyCode.right:
      spriteSpeed = Speed(x: 0, y: spriteSpeed.y)
      
    case Const.KeyCode.down:
      spriteSpeed = Speed(x: spriteSpeed.x, y: 0)
      
    case Const.KeyCode.up:
      spriteSpeed = Speed(x: spriteSpeed.x, y: 0)
      
    default:
      break
    }
  }
  
  override func update(currentTime: CFTimeInterval) {
    updateSpaceship()
    updateBullet()
  }
  
  private func updateSpaceship() {
    var resultFrame = sprite.frame
    resultFrame.origin.x += spriteSpeed.x
    resultFrame.origin.y += spriteSpeed.y
    
    guard !frameCollideWithBorders(resultFrame) else {
      return
    }
    
    var resultPosition = sprite.position
    resultPosition.x += spriteSpeed.x
    resultPosition.y += spriteSpeed.y
    sprite.position = resultPosition
  }
  
  private func updateBullet() {
    var resultPosition = bullet.position
    resultPosition.x += currentTrack.radius * cos(currentTrack.angle)
    resultPosition.y += currentTrack.radius * sin(currentTrack.angle)
    bullet.position = resultPosition
    
    currentTrack = Track(
      radius: currentTrack.radius + deltaTrack.radius,
      angle: currentTrack.angle + deltaTrack.angle)
  }
  
}

private let π = CGFloat(M_PI)

extension MoveScene {
  
  private struct Const {
    struct Asset {
      static let spaceship = "Spaceship"
      static let bullet = "bullet"
    }
    
    struct Logic {
      static let spaceshipInitialScale: CGFloat = 0.25
      static let keyDownDelay: NSTimeInterval = 0.3
      static let speed: CGFloat = 6
    }
    
    struct KeyCode {
      static let left = 123
      static let right = 124
      static let down = 125
      static let up = 126
    }
  }
  
  private struct Speed {
    let x: CGFloat
    let y: CGFloat
  }
  
  private struct Track {
    let radius: CGFloat
    let angle: CGFloat
    
    init(radius: CGFloat, angle: CGFloat) {
      self.radius = radius
      self.angle = angle > 2 * π ? angle % (2 * π) : angle
    }
  }
  
}
