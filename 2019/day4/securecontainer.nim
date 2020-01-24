# Day 4: Secure Container
import strutils, sequtils

proc group(s: string): seq[seq[string]] =
  var t: seq[string]
  for i, c in s.pairs:
    if t.len == 0 or t.contains($c):
      t.add($c)
    else:
      result.add(t)
      t = @[$c]
  if t.len > 0:
    result.add(t)

proc hasDouble(s: string): bool =
  result = group(s).mapIt(it.join).filterIt(it.len == 2).len > 0

proc hasIncreasing(s: string): bool =
  result = true
  for i, c in s.pairs:
    if i+1 >= s.len: break
    elif parseInt($s[i+1]) < parseInt($c): return false

proc solve(s: string): int =
  let l: int = parseInt(s[0..5])
  let h: int = parseInt(s[7..^1])
  var t: seq[int]
  for n in l..h:
    if hasIncreasing($n) and hasDouble($n):
      t.add(n)
  result = t.len

let inputs = "234208-765869"
echo "Answer: ", solve(inputs)
