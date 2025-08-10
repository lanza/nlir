//
//  main.swift
//  Lily
//
//  Created by Nathan Lanza on 11/17/22.
//

import Foundation

class Function: Operation {
  var insertionPoint: (Int, Int) = (0, 0)

  func getFunctionName() -> String {
    return (attributes["functionName"] as! StringAttribute).value
  }

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
      Value(ty: value.getTy(), definingOperation: self, name: name))
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
    results.append(Value(ty: lhs.getTy(), definingOperation: self))
  }
}

class TypeAttribute: Attribute {
  let ty: Ty
  init(type: Ty) {
    self.ty = type
  }

  override var debugDescription: String {
    if ty is FunctionTy {
      let ft = ty as! FunctionTy

      let args =
        "(\(ft.arguments.map { $0.debugDescription }.joined(separator: ", ")))"
      let results =
        "(\(ft.results.map { $0.debugDescription }.joined(separator: ", ")))"

      return args + " -> " + results

    } else {
      fatalError("IDK")
    }

  }
}

class Attribute: CustomDebugStringConvertible {
  func getTy() -> Ty {
    fatalError("Can't use base attribute")
  }

  var debugDescription: String {
    fatalError("Can't use base attribute")
  }
}

class I64Attribute: Attribute {
  let value: Int64
  init(value: Int64) {
    self.value = value
  }
  override func getTy() -> Ty {
    return I64Ty.get()
  }

  override var debugDescription: String {
    return String(value)
  }
}
class StringAttribute: Attribute {
  let value: String
  init(value: String) {
    self.value = value
  }
  override func getTy() -> Ty {
    return StringTy.get()
  }

  override var debugDescription: String {
    return "\"\(value)\""
  }
}

let main = Function(name: "main", type: FunctionTy())
let bb = main.getBody().appendNewBasicBlock()

let lhs = ConstantOp(value: I64Attribute(value: 44))
main.appendOp(lhs)
let rhs = ConstantOp(value: I64Attribute(value: 33))
main.appendOp(rhs)
main.appendOp(AddOp(lhs: lhs.results.first!, rhs: rhs.results.first!))

main.print()
