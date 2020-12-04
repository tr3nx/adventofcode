# day 4 - passport processing

import strutils

proc solvePartOne(filename: string): int =
  const required = @["byr","iyr","eyr","hgt","hcl","ecl","pid"]
  var checks: int

  for line in filename.lines:
    if line != "":
      for req in required:
        if line.contains(req):
          checks.inc
    else:
      if checks > 0:
        if checks == required.len:
          result.inc
        checks = 0

proc solvePartTwo(filename: string): int =
  const required = @["byr","iyr","eyr","hgt","hcl","ecl","pid"]
  var checks: int

  for line in filename.lines:
    if line != "":
      for keyvalues in line.split(" "):
        var
          keyvalue = keyvalues.split(":")
          key = keyvalue[0]
          value = keyvalue[1]

        if key == "byr" and value.len == 4:
          var v = parseInt(value)
          if v >= 1920 and v <= 2002:
            checks.inc

        if key == "iyr" and value.len == 4:
          var v = parseInt(value)
          if v >= 2010 and v <= 2020:
            checks.inc

        if key == "eyr" and value.len == 4:
          var v = parseInt(value)
          if v >= 2020 and v <= 2030:
            checks.inc

        if key == "hgt":
          if value.contains("in"):
            var vs = value.split("i")

            if vs.len == 2:
              var
                h = parseInt(vs[0])
                m = vs[1]

              if m == "n" and h >= 59 and h <= 76:
                checks.inc

          if value.contains("cm"):
            var vs = value.split("c")

            if vs.len == 2:
              var
                h = parseInt(vs[0])
                m = vs[1]

              if m == "m" and h >= 150 and h <= 193:
                checks.inc

        if key == "hcl" and value.len == 7 and value[0] == '#':
          var check: int
          for v in value[1..^1]:
            if isAlphaNumeric(v):
              check.inc

          if check == 6:
            checks.inc

        if key == "ecl" and @["amb","blu","brn","gry","grn","hzl","oth"].contains(value):
            checks.inc

        if key == "pid":
          if value[0] == '0' and value.len == 9 and parseInt(value[1..^1]) > 0:
            checks.inc

          if value[0] != '0' and value.len == 9 and parseInt(value[1..^1]) > 0:
            checks.inc

    else:
      if checks > 0:
        if checks == required.len:
          result.inc
        checks = 0

  if checks > 0:
    if checks == required.len:
      result.inc

echo solvePartOne("day4.in")
echo solvePartTwo("day4.in")
