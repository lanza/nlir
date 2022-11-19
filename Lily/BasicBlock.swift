//
//  File.swift
//  Lily
//
//  Created by Nathan Lanza on 11/18/22.
//

import Foundation

class BasicBlock {
  var arguments: [Value]
  var operations: [Operation]
  init(arguments: [Value] = [], operations: [Operation] = []) {
    self.arguments = arguments
    self.operations = operations
  }
}
