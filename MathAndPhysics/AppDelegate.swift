//
//  AppDelegate.swift
//  MathAndPhysics
//
//  Created by Yan Li on 10/31/15.
//  Copyright (c) 2015 eyeplum. All rights reserved.
//


import Cocoa
import SpriteKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  
  @IBOutlet weak var window: NSWindow!
  @IBOutlet weak var skView: SKView!
  
  func applicationDidFinishLaunching(aNotification: NSNotification) {
    window.acceptsMouseMovedEvents = true
    
    presentMenu()
  }
  
}

extension AppDelegate {
  
  private func presentMenu() {
    guard let scene = MenuScene(fileNamed: "") else {
      return
    }
    
    presentScene(scene)
  }
  
  private func presentMoveScene() {
    guard let scene = MoveScene(fileNamed: "") else {
      return
    }
    
    presentScene(scene)
  }
  
  private func presentScene(scene: SKScene) {
    scene.scaleMode = .AspectFit
    
    skView.showsFPS = true
    skView.showsNodeCount = true
    
    skView.presentScene(scene)
    window.makeFirstResponder(scene)
  }
  
}
