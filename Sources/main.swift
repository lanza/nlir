import Foundation

let main = Function(
  name: "main",
  type: FunctionTy(arguments: [I64Ty.get()], results: [I64Ty.get()]))
let bb = main.getBody().appendNewBasicBlock(
  args: main.getFunctionType().arguments)

let lhs = ConstantOp(value: I64Attribute(value: 44))
assert(verify(op: lhs))
main.appendOp(lhs)
let rhs = ConstantOp(value: I64Attribute(value: 33))
assert(verify(op: rhs))
main.appendOp(rhs)
let add = AddOp(lhs: lhs.results.first!, rhs: rhs.results.first!)
assert(verify(op: add))
main.appendOp(add)

let addAgain = AddOp(lhs: add.getResult(), rhs: bb.arguments.first!)
main.appendOp(addAgain)
let ret = ReturnOp(value: addAgain.getResult())
assert(verify(op: ret))
main.appendOp(ret)

assert(verify(op: main))

main.print()
