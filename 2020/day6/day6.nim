# day 6 - custom customs

import strutils

proc solvePartOne(filename: string): int =
  var
    groups: seq[string]
    group: string

  for line in filename.lines:
    if line != "":
      group = group & line
    else:
      groups.add group
      group = ""

  if group.len > 0:
    groups.add group

  for answers in groups:
    var uniques: seq[char]

    for a in answers:
      if not uniques.contains(a):
        uniques.add a

    result += uniques.len


proc solvePartTwo(filename: string): int =
  var
    groups: seq[seq[string]]
    group: seq[string]

  for line in filename.lines:
    if line != "":
      group.add line
    else:
      groups.add group
      group = @[]

  if group.len > 0:
    groups.add group

  for grp in groups:
    if grp.len == 1:
      result += grp[0].len
    else:
      var
        sgrp = grp.join("")
        yes: seq[char]

      for ans in sgrp:
        if sgrp.count(ans) == grp.len and not yes.contains(ans):
          yes.add ans
          result.inc

echo solvePartOne("day6.in")
echo solvePartTwo("day6.in")
