//
//  Attributes.swift
//  Lily
//
//  Created by Nathan Lanza on 11/18/22.
//

import Foundation

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
