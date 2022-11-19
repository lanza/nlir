//
//  Operation.swift
//  Lily
//
//  Created by Nathan Lanza on 11/18/22.
//

import Foundation

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
