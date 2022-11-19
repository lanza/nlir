//
//  BuiltinOps.swift
//  Lily
//
//  Created by Nathan Lanza on 11/18/22.
//

import Foundation

class Function: Operation, FunctionLike {
  var insertionPoint: (Int, Int) = (0, 0)

  override func getName() -> String {
    return "func"
  }

  func getBody() -> Region {
    return regions[0]
  }

  init(name: String, type: FunctionTy) {
    super.init()
    self.regions.append(Region())
    self.attributes["functionName"] = StringAttribute(value: name)
    self.attributes["functionType"] = TypeAttribute(type: type)
  }

  func appendOp(_ op: Operation) {
    let bb = getBody().basicBlocks[insertionPoint.0]
    bb.operations.append(op)
    insertionPoint.1 = bb.operations.count
  }
}

class ConstantOp: Operation, OneTypedResult {
  override func getName() -> String {
    return "constant"
  }

  init(value: Attribute, name: String? = nil) {
    super.init()
    attributes["value"] = value

    results.append(
      OpResult(ty: value.getTy(), op: self, name: name))
  }
}

class AddOp: Operation, OneTypedResult {
  override func getName() -> String {
    return "add"
  }

  init(lhs: Value, rhs: Value) {
    super.init()

    assert(lhs.getTy() === rhs.getTy())

    operands.append(lhs)
    operands.append(rhs)
    results.append(OpResult(ty: lhs.getTy(), op: self))
  }
}

class ReturnOp: Operation, OneArgument {
  override func getName() -> String {
    return "return"
  }

  init(value: Value) {
    super.init()
    self.operands.append(value)
  }
}
