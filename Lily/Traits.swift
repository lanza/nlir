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
