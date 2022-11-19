//
//  Traits.swift
//  Lily
//
//  Created by Nathan Lanza on 11/18/22.
//

import Foundation

protocol OneResult: Operation {
  func getResult() -> Value
}
extension OneResult {
  func getResult() -> Value { results.first! }
}

protocol OneTypedResult: Operation, OneResult {
  func getType() -> Ty
}
extension OneTypedResult {
  func getType() -> Ty { return results.first!.getTy() }
}

protocol OneRegion: Operation {
  func getRegion() -> Region
}
extension OneRegion {
  func getRegion() -> Region { regions.first! }
}

protocol OneArgument: Operation {
}

protocol FunctionLike: Operation, OneRegion {
  func getFunctionType() -> FunctionTy
  func getFunctionName() -> String
}
extension FunctionLike {
  func getFunctionType() -> FunctionTy {
    return (attributes["functionType"] as! TypeAttribute).ty as! FunctionTy
  }
  func getFunctionName() -> String {
    return (attributes["functionName"] as! StringAttribute).value
  }
}
