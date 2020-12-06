open Tablecloth

// Step one
"day06.txt"
->Utils.readFile
->Js.String2.split("\n\n")
->Array.map(~f=s => Js.String.replaceByRe(%re("/\\n/g"), "", s))
->Array.map(~f=Utils.stringToArray)
->Array.map(~f=Belt.Set.String.fromArray)
->Array.map(~f=Belt.Set.String.size)
->Array.sum
->Utils.teeLog

// Step two
let alphaset = "abcdefghijklmnopqrstuvwxyz"->Utils.stringToArray->Belt.Set.String.fromArray

"day06.txt"
->Utils.readFile
->Js.String2.split("\n\n")
->Array.map(~f=s => s->Js.String2.split("\n"))
->Array.map(~f=s => s->Array.map(~f=Utils.stringToArray))
->Array.map(~f=s => s->Array.map(~f=Belt.Set.String.fromArray))
->Array.map(~f=s => s->Array.foldLeft(~f=Belt.Set.String.intersect, ~initial=alphaset))
->Array.map(~f=Belt.Set.String.size)
->Array.sum
->Utils.teeLog
