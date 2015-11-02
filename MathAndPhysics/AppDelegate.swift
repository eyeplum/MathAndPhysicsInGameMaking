//
//  AppDelegate.swift
//  MathAndPhysics
//
//  Created by Yan Li on 10/31/15.
//  Copyright (c) 2015 eyeplum. All rights reserved.
//


import Cocoa
import SpriteKit

struct Notification {
  struct Name {
    static let presentMove = "com.MathAndPhysics.move"
    static let presentGravity = "com.MathAndPhysics.gravity"
  }
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  
  @IBOutlet weak var window: NSWindow!
  @IBOutlet weak var skView: SKView!
  
  func applicationDidFinishLaunching(aNotification: NSNotification) {
    window.acceptsMouseMovedEvents = true
    
    observeNotifications()
    presentMenu()
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
}

extension AppDelegate {
  
  private func observeNotifications() {
    NSNotificationCenter.defaultCenter().addObserverForName(Notification.Name.presentMove, object: nil, queue: NSOperationQueue.mainQueue()) { _ in
      self.presentMoveScene()
    }
    
    NSNotificationCenter.defaultCenter().addObserverForName(Notification.Name.presentGravity, object: nil, queue: NSOperationQueue.mainQueue()) { _ in
      self.presentGravityScene()
    }
  }
  
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
  
  private func presentGravityScene() {
    // ...
  }
  
  private func presentScene(scene: SKScene) {
    scene.scaleMode = .AspectFit
    
    skView.showsFPS = true
    skView.showsNodeCount = true
    
    skView.presentScene(scene, transition: SKTransition.doorwayWithDuration(1.0))
    window.makeFirstResponder(scene)
  }
  
}
