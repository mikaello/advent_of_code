@bs.module("fs") external read: (string, string) => string = "readFileSync"

let readFile = filename => {
  read(`./${filename}`, "utf-8")->Js.String.trim
}
