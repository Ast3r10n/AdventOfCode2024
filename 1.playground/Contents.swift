import Foundation

guard let listFile = Bundle.main.url(forResource: "input", withExtension: "txt") else {
    fatalError("Couldn't find input file")
}

let list = try String(contentsOf: listFile, encoding: .utf8).split(separator: "\n")

var leftValues = [Int]()
var rightValues = [Int]()

list.forEach { line in
    let components = line.split(separator: "   ")
    guard components.count == 2,
        let leftValue = Int(components[0]),
        let rightValue = Int(components[1]) else {
        fatalError("Invalid line: \(line)")
    }

    leftValues.append(leftValue)
    rightValues.append(rightValue)
}

// Part One
func getDistance(_ leftArray: [Int], _ rightArray: [Int]) -> UInt {
    var leftArray = leftArray
    var rightArray = rightArray

    func _getDistance(_ leftArray: inout [Int], _ rightArray: inout [Int]) -> UInt {
        guard let (leftIndex, _) = leftArray.enumerated().min(by: { $0.element < $1.element }),
              let (rightIndex, _) = rightArray.enumerated().min(by: { $0.element < $1.element }) else {
            return 0
        }

        return ((leftArray.remove(at: leftIndex) - rightArray.remove(at: rightIndex)).magnitude) + _getDistance(&leftArray, &rightArray)
    }

    return _getDistance(&leftArray, &rightArray)
}

getDistance(leftValues, rightValues)
