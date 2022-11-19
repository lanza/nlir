//
//  Region.swift
//  Lily
//
//  Created by Nathan Lanza on 11/18/22.
//

import Foundation

class Region {
  var basicBlocks: [BasicBlock]
  init(basicBlocks: [BasicBlock] = []) {
    self.basicBlocks = basicBlocks
  }

  func appendNewBasicBlock() -> BasicBlock {
    basicBlocks.append(BasicBlock())
    return basicBlocks.last!
  }
}
