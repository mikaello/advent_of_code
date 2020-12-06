@bs.module("fs") external read: (string, string) => string = "readFileSync"

open Tablecloth

type choice =
  | Range(int, int)
  | Found(int)

let toCoordinates = boardingPass => {
  let rec findCode = (boardingPass, row, seat) => {
    switch boardingPass {
    | list{"F", ...rest} =>
      switch row {
      | Range(f, t) =>
        if t - f == 1 {
          findCode(rest, Found(f), seat)
        } else {
          findCode(rest, Range(f, (f + t) / 2), seat)
        }
      | _ => raise(Not_found)
      }
    | list{"B", ...rest} =>
      switch row {
      | Range(f, t) =>
        if t - f == 1 {
          findCode(rest, Found(t), seat)
        } else {
          findCode(rest, Range((t + f) / 2 + 1, t), seat)
        }
      | _ => raise(Not_found)
      }
    | list{"R", ...rest} =>
      switch seat {
      | Range(l, r) =>
        if r - l == 1 {
          findCode(rest, row, Found(r))
        } else {
          findCode(rest, row, Range((r + l) / 2 + 1, r))
        }
      | _ => raise(Not_found)
      }
    | list{"L", ...rest} =>
      switch seat {
      | Range(l, r) =>
        if r - l == 1 {
          findCode(rest, row, Found(l))
        } else {
          findCode(rest, row, Range(l, (l + r) / 2))
        }
      | _ => raise(Not_found)
      }
    | list{a, ...rest} =>
      Js.log("SHOULD NOT HAPPEN /" ++ a ++ "/")
      findCode(rest, row, seat)
    | _ => (row, seat)
    }
  }

  findCode(boardingPass, Range(0, 127), Range(0, 7))
}

let split = s => s |> Js.String.split("") |> Array.to_list

let getRowSeat = ((row, seat)) => {
  let row = switch row {
  | Found(num) => num
  | Range(_, _) => raise(Not_found)
  }
  let seat = switch seat {
  | Found(num) => num
  | Range(_, _) => raise(Not_found)
  }

  row * 8 + seat
}

let printTee = any => {
  Js.log(any)
  any
}

let input0 = `BFFFBBFRRR` // 567
let input1 = `FFFBBBFRRR` // 119
let inputX = read("./day05.txt", "utf-8")->Js.String.trim->Js.String2.split("\n")

let a = inputX
// |> Array.map(~f=printTee)
|> Array.map(~f=Js.String.trim)
|> Array.filter(~f=s => String.length(s) > 0)
|> Array.map(~f=input => input->split->toCoordinates->getRowSeat)
|> Array.toList
// |> get maximum value in step one of task
|> List.sort_with((a, b) => a - b)

let b = Array.initialize(~length=873, ~f=i => i + 63)
Js.log(Array.sum(b) - List.sum(a))
