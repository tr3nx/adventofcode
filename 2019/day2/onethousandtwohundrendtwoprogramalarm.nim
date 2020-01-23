# Day 2: 1202 Program Alarm

proc run(xs: var seq[int]): int =
  var i: int
  while i < xs.len:
    case xs[i]
    of 99: break
    of 1:
      xs[xs[i+3]] = xs[xs[i+1]] + xs[xs[i+2]]
      i = i + 4
    of 2:
      xs[xs[i+3]] = xs[xs[i+1]] * xs[xs[i+2]]
      i = i + 4
    else: quit(-1)
  xs[0]

proc setValue(xs: var seq[int], n,x: int): var seq[int] =
  result = xs
  xs[n] = x

proc bruteforce(original: seq[int], target: int): int =
  var xs: seq[int]
  for noun in 0..99:
    for verb in 0..99:
      xs = original
      if target == xs.setValue(1, noun).setValue(2, verb).run:
        result = (100 * noun) + verb
        return

let codes = @[1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,6,1,19,1,5,19,23,2,6,23,27,1,27,5,31,2,9,31,35,1,5,35,39,2,6,39,43,2,6,43,47,1,5,47,51,2,9,51,55,1,5,55,59,1,10,59,63,1,63,6,67,1,9,67,71,1,71,6,75,1,75,13,79,2,79,13,83,2,9,83,87,1,87,5,91,1,9,91,95,2,10,95,99,1,5,99,103,1,103,9,107,1,13,107,111,2,111,10,115,1,115,5,119,2,13,119,123,1,9,123,127,1,5,127,131,2,131,6,135,1,135,5,139,1,139,6,143,1,143,6,147,1,2,147,151,1,151,5,0,99,2,14,0,0]
var first = codes
var second = codes
echo "First answer: ", first.setValue(1, 12).setValue(2, 2).run
echo "Second answer: ", second.bruteforce(19690720)
