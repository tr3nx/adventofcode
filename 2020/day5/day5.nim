# day 5 - binary boarding

import algorithm

proc solvePartOne(filename: string): int =
  for line in filename.lines:
    var
      rows: tuple[lower, upper: int] = (0, 127)
      cols: tuple[lower, upper: int] = (0, 7)
      row: int
      col: int

    for r in line[0..6]:
      if r == 'F':
        var newupper = rows.upper - int((rows.upper - rows.lower) / 2) - 1
        rows = (rows.lower, newupper)

      if r == 'B':
        var newlower = rows.lower + int((rows.upper - rows.lower) / 2) + 1
        rows = (newlower, rows.upper)

    row = rows.lower

    for c in line[^3..^1]:
      if c == 'L':
        var newupper = cols.upper - int((cols.upper - cols.lower) / 2) - 1
        cols = (cols.lower, newupper)

      if c == 'R':
        var newlower = cols.lower + int((cols.upper - cols.lower) / 2) + 1
        cols = (newlower, cols.upper)

    col = cols.lower

    var attempt = (row * 8) + col
    if attempt > result:
      result = attempt

proc solvePartTwo(filename: string): int =
  var
    seats: seq[int]
    guess: int

  for line in filename.lines:
    var
      rows: tuple[lower, upper: int] = (0, 127)
      cols: tuple[lower, upper: int] = (0, 7)
      row: int
      col: int

    for r in line[0..6]:
      if r == 'F':
        var newupper = rows.upper - int((rows.upper - rows.lower) / 2) - 1
        rows = (rows.lower, newupper)

      if r == 'B':
        var newlower = rows.lower + int((rows.upper - rows.lower) / 2) + 1
        rows = (newlower, rows.upper)

    row = rows.lower

    for c in line[^3..^1]:
      if c == 'L':
        var newupper = cols.upper - int((cols.upper - cols.lower) / 2) - 1
        cols = (cols.lower, newupper)

      if c == 'R':
        var newlower = cols.lower + int((cols.upper - cols.lower) / 2) + 1
        cols = (newlower, cols.upper)

    col = cols.lower

    seats.add (row * 8) + col

  seats = seats.sorted
  for i, seat in seats.pairs:
    if i + 1 < seats.len and seats[i + 1] - seat > 1:
      guess = seat + 1

  return guess

echo solvePartOne("day5.in")
echo solvePartTwo("day5.in")
