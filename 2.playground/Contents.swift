import Foundation

guard let listFile = Bundle.main.url(forResource: "input", withExtension: "txt") else {
    fatalError("Couldn't find input file")
}

let list = try String(contentsOf: listFile, encoding: .utf8).split(separator: "\n")

var safeReportsCount = 0

func isReportSafe(_ report: [Int]) -> Bool {
    func check(_ report: [Int], signum: Int? = nil) -> Bool {
        guard let first = report.first, let second = report.dropFirst().first else { return true }
        let count = report.count

        let difference = first - second
        let currentSignum = signum ?? difference.signum()

        guard difference.signum() == currentSignum, (1...3) ~= difference.magnitude else { return false }
        return check(Array(report.dropFirst()), signum: currentSignum)
    }

    if check(report) { return true }

    return report.enumerated().contains { index, element in
        var reportCopy = report
        reportCopy.remove(at: index)

        return check(reportCopy)
    }
}

list.forEach {
    var report = $0
        .split(separator: " ")
        .map(String.init)
        .compactMap(Int.init)

    if isReportSafe(report) {
        safeReportsCount += 1
    }
}

print("Safe reports: \(safeReportsCount)")
