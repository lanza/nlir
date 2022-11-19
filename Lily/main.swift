//
//  main.swift
//  Lily
//
//  Created by Nathan Lanza on 11/17/22.
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

class BasicBlock {
  var arguments: [Value]
  var operations: [Operation]
  init(arguments: [Value] = [], operations: [Operation] = []) {
    self.arguments = arguments
    self.operations = operations
  }
}

class Operation {
  func getName() -> String {
    fatalError("Can't use base Operation")
  }
  var operands: [Value]
  var results: [Value]

  var attributes: [String: Attribute]

  var regions: [Region]

  init() {
    self.operands = []
    self.results = []
    self.attributes = [:]
    self.regions = []
  }

  func print(terminator: String = "\n") {
    defer {
      Swift.print(terminator, terminator: "")
    }
    assert(results.count <= 1)

    if !results.isEmpty {
      Swift.print("%\(results[0].name) = ", terminator: "")
    }

    Swift.print("\(getName())", terminator: "")

    if !operands.isEmpty {
      Swift.print(" (", terminator: "")
    }

    Swift.print(
      operands.map { "%\($0.name)" }.joined(separator: ", "), terminator: "")

    if !operands.isEmpty {
      Swift.print(")", terminator: "")
    }

    if !attributes.isEmpty {
      Swift.print(" {", terminator: "")
    }

    Swift.print(
      attributes.map({ element in
        "\(element.key) : \(element.value)"
      }).joined(separator: ", "), terminator: "")

    if !attributes.isEmpty {
      Swift.print("}", terminator: "")
    }

    if regions.isEmpty {
      return
    }

    Swift.print(" {")

    let bb = regions[0].basicBlocks[0]

    for (index, operation) in bb.operations.enumerated() {
      Swift.print("  ", terminator: "")
      operation.print(terminator: "")

      if index + 1 < bb.operations.count {
        Swift.print("")
      }
    }

    Swift.print("")
    Swift.print("}")
  }
}

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
