//
//  Value.swift
//  Lily
//
//  Created by Nathan Lanza on 11/18/22.
//

import Foundation

class Value {
  private let ty: Ty
  let definingOperation: Operation
  let name: String

  func getTy() -> Ty {
    return ty
  }

  static var nextDefaultName = 1

  init(ty: Ty, definingOperation: Operation, name: String? = nil) {
    self.ty = ty
    self.definingOperation = definingOperation

    if let name = name {
      self.name = name
    } else {
      self.name = "val\(Value.nextDefaultName)"
      Value.nextDefaultName += 1
    }
  }
}
