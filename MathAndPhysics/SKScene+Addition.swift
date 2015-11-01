//
//  SKScene+Addition.swift
//  MathAndPhysics
//
//  Created by Yan Li on 11/1/15.
//  Copyright © 2015 eyeplum. All rights reserved.
//

import SpriteKit

extension SKScene {
  
  var center: CGPoint {
    return CGPoint(x: size.width/2, y: size.height/2)
  }
  
  func frameCollideWithBorders(frame: CGRect) -> Bool {
    return frame.minX <= 0 ||
           frame.minY <= 0 ||
           frame.maxX >= size.width ||
           frame.maxY >= size.height
  }
  
}