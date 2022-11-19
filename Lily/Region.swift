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

  func appendNewBasicBlock(args: [Ty] = []) -> BasicBlock {
    basicBlocks.append(BasicBlock(argumentTypes: args))
    return basicBlocks.last!
  }
}
