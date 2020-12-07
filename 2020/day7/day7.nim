# day 7 - handy haversacks

import strutils, sequtils

type
  bag = ref object
    name: string
    count: int
    bags: seq[bag]

proc checkBags(target: string, bags: seq[bag]): seq[string] =
  for bag in bags:
    if bag.bags.filterIt(it.name == target).len > 0:
      result.add bag.name & checkBags(bag.name, bags)

proc solvePartOne(filename: string): int =
  var allbags: seq[bag]

  for line in filename.lines:
    var
      splits = line.split(" bags contain ")
      curbag = bag(name: splits[0].replace(" ", ""))

    for bgx in splits[1].replace(".", "").split(", "):
      var
        asdf = bgx.split(" ", 1)
        name = asdf[1].rsplit(" ", 1)[0].replace(" ", "")
        num = if asdf[0] == "no": 0 else: parseInt(asdf[0])

      if name != "other":
        curbag.bags.add bag(name: name, count: num)
        curbag.count = curbag.bags.len

    allbags.add curbag

  return checkBags("shinygold", allbags).deduplicate().len

echo solvePartOne("day7.in")
