//
//  Value.swift
//  Lily
//
//  Created by Nathan Lanza on 11/18/22.
//

import Foundation

class Value {
  private let ty: Ty
  let name: String

  func getTy() -> Ty {
    return ty
  }

  static var nextDefaultName = 1

  init(ty: Ty, name: String? = nil) {
    self.ty = ty

    if let name = name {
      self.name = name
    } else {
      self.name = "val\(Value.nextDefaultName)"
      Value.nextDefaultName += 1
    }
  }
}

class OpResult: Value {
  let definingOperation: Operation
  init(ty: Ty, op: Operation, name: String? = nil) {
    self.definingOperation = op
    super.init(ty: ty, name: name)
  }
}

class BlockArgument: Value {
  let owningBlock: BasicBlock
  init(ty: Ty, block: BasicBlock, name: String? = nil) {
    self.owningBlock = block
    super.init(ty: ty, name: name)
  }
}
