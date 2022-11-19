//
//  main.swift
//  Lily
//
//  Created by Nathan Lanza on 11/17/22.
//

import Foundation

let main = Function(name: "main", type: FunctionTy())
let bb = main.getBody().appendNewBasicBlock()

let lhs = ConstantOp(value: I64Attribute(value: 44))
main.appendOp(lhs)
let rhs = ConstantOp(value: I64Attribute(value: 33))
main.appendOp(rhs)
main.appendOp(AddOp(lhs: lhs.results.first!, rhs: rhs.results.first!))

main.print()
