import Foundation

guard let listFile = Bundle.main.url(forResource: "input", withExtension: "txt") else {
    fatalError("Couldn't find input file")
}

let text = try String(contentsOf: listFile, encoding: .utf8)

let regex = /mul\((\d{1,3}),(\d{1,3})\)/

let sum = text
    .matches(of: regex)
    .reduce(into: 0) { result, match in
        guard let first = Int(match.1), let second = Int(match.2) else { return }
        result += first * second
    }
print("Sum: \(sum)")
