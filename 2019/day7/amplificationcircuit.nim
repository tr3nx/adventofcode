# Day 7: Amplification Circuit
import strutils

proc parseModes(op: string): seq[int] =
  for o in op:
    if o == '1': result.add(1)
    else: result.add(0)

proc parseOp(op: int): tuple[modes: seq[int], op: int] =
  result =
    if op > 99:
      var sop = $op
      (parseModes(sop[0..^3]), parseInt(sop[^2..^1]))
    else:
      (@[0], op)

proc run(ops: var seq[int], inputs: seq[int]): int =
  var ip: int
  var op: int
  var modes: seq[int]
  var mode: int
  var inputCounter: int
  while ip < ops.len:
    (modes, op) = parseOp(ops[ip])
    inc(ip)
    case op
    of 1: # add
      mode = if modes.len > 0: modes.pop else: 0
      var a = if mode == 0: ops[ops[ip]] else: ops[ip]
      inc(ip)

      mode = if modes.len > 0: modes.pop else: 0
      var b = if mode == 0: ops[ops[ip]] else: ops[ip]
      inc(ip)

      ops[ops[ip]] = a + b
      inc(ip)

    of 2: # multi
      mode = if modes.len > 0: modes.pop else: 0
      var a = if mode == 0: ops[ops[ip]] else: ops[ip]
      inc(ip)

      mode = if modes.len > 0: modes.pop else: 0
      var b = if mode == 0: ops[ops[ip]] else: ops[ip]
      inc(ip)

      ops[ops[ip]] = a * b
      inc(ip)

    of 3: # set
      ops[ops[ip]] = inputs[inputCounter]
      inc(inputCounter)
      inc(ip)

    of 4: # get
      mode = if modes.len > 0: modes.pop else: 0
      var dst = if mode == 0: ops[ip] else: ip
      inc(ip)
      result = ops[dst]

    of 5: # jump true
      mode = if modes.len > 0: modes.pop else: 0
      var check = if mode == 0: ops[ops[ip]] else: ops[ip]
      inc(ip)
      if check > 0:
        mode = if modes.len > 0: modes.pop else: 0
        ip = if mode == 0: ops[ops[ip]] else: ops[ip]
      else:
        inc(ip)

    of 6: # jump false
      mode = if modes.len > 0: modes.pop else: 0
      var check = if mode == 0: ops[ops[ip]] else: ops[ip]
      inc(ip)
      if check == 0:
        mode = if modes.len > 0: modes.pop else: 0
        ip = if mode == 0: ops[ops[ip]] else: ops[ip]
      else:
        inc(ip)

    of 7: # less than
      mode = if modes.len > 0: modes.pop else: 0
      var a = if mode == 0: ops[ops[ip]] else: ops[ip]
      inc(ip)

      mode = if modes.len > 0: modes.pop else: 0
      var b = if mode == 0: ops[ops[ip]] else: ops[ip]
      inc(ip)

      ops[ops[ip]] = if a < b: 1 else: 0
      inc(ip)

    of 8: # equal
      mode = if modes.len > 0: modes.pop else: 0
      var a = if mode == 0: ops[ops[ip]] else: ops[ip]
      inc(ip)

      mode = if modes.len > 0: modes.pop else: 0
      var b = if mode == 0: ops[ops[ip]] else: ops[ip]
      inc(ip)

      ops[ops[ip]] = if a == b: 1 else: 0
      inc(ip)

    of 99: break
    else: quit(-1)


var phases = @[1,0,4,3,2]
var codes = @[3,8,1001,8,10,8,105,1,0,0,21,34,55,68,93,106,187,268,349,430,99999,3,9,102,5,9,9,1001,9,2,9,4,9,99,3,9,1001,9,5,9,102,2,9,9,101,2,9,9,102,2,9,9,4,9,99,3,9,101,2,9,9,102,4,9,9,4,9,99,3,9,101,4,9,9,102,3,9,9,1001,9,2,9,102,4,9,9,1001,9,2,9,4,9,99,3,9,101,2,9,9,1002,9,5,9,4,9,99,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,99,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,99,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,99,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,99]

var ampOutput: int
for _, p in phases:
  ampOutput = codes.run(@[p, ampOutput])

echo "Answer: ", ampOutput
