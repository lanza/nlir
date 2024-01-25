//
//  File.swift
//  Lily
//
//  Created by Nathan Lanza on 11/18/22.
//

import Foundation

private var nextBlockName = 0

class BasicBlock {
  let name: String
  var arguments: [Value]
  var operations: [Operation]
  init(
    argumentTypes: [Ty] = [], operations: [Operation] = [], name: String? = nil
  ) {
    self.arguments = []
    self.operations = operations
    if let name = name {
      self.name = "^\(name)"
    } else {
      self.name = "^bb\(nextBlockName)"
      nextBlockName += 1
    }

    arguments = argumentTypes.map { BlockArgument(ty: $0, block: self) }
  }
}
