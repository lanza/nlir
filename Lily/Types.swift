//
//  Types.swift
//  Lily
//
//  Created by Nathan Lanza on 11/18/22.
//

import Foundation

class Ty: CustomDebugStringConvertible {
  var debugDescription: String {
    fatalError("IDK")
  }
}

class FunctionTy: Ty {
  let arguments: [Ty]
  let results: [Ty]
  init(arguments: [Ty] = [], results: [Ty] = []) {
    self.arguments = arguments
    self.results = results
  }
}

class I64Ty: Ty {
  static let this = I64Ty()
  static func get() -> I64Ty { return this }
}

class StringTy: Ty {
  static let this = StringTy()
  static func get() -> StringTy { return this }
}
