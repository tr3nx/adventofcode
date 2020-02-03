# Day 6: Universal Orbit Map
import strutils, sequtils, sugar

type
  ParsedOrbit = tuple[sig, child: string]
  Orbit = object
    parent: string
    sig: string
    child: string
    children: seq[Orbit]

proc parseOrbit(o: string): ParsedOrbit =
  var s = o.split(")")
  (sig: s[0], child: s[1])

proc buildTree(orb: Orbit, orbs: seq[ParsedOrbit]): Orbit =
  result = orb
  let childOrbs = orbs.filter(o => o.sig == orb.child)
  if childOrbs.len <= 0:
    result.children.add Orbit(parent: orb.sig, sig: orb.child)
  else:
    for _, co in childOrbs:
      let orbit = Orbit(parent: orb.sig, sig: co.sig, child: co.child)
      result.children.add orbit.buildTree(orbs)

proc calculateOrbits(orb: Orbit, dst: string): int =
  #


# main
var orbitData =
  # @["XYZ)YOU", "XYZ)OUR", "OUR)JFK", "JFK)ASD", "ASD)FGH", "ABC)DEF", "DEF)XYZ"]
  @["B)C","C)D","D)E","E)F","B)G","G)H","D)I","E)J","J)K","K)L"]
  .map(parseOrbit)

# answer is larger than 5137
# child: WLQ
var orbit = Orbit(sig: "COM", child: "B").buildTree(orbitData)
# echo orbit

echo "B ", orbit.calculateOrbits("B")

# echo orbitData.mapIt(orbit.calculateOrbits(it.sig)).foldl(a + b)
