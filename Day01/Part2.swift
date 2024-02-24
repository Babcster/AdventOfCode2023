import Foundation

let numberWordsToDigits: [String: String] = [
    "zero": "0",
    "one": "1",
    "two": "2",
    "three": "3",
    "four": "4",
    "five": "5",
    "six": "6",
    "seven": "7",
    "eight": "8",
    "nine": "9"
]

func processLine(_ line: String) -> String {
    var processedLine = line
    for (word, digit) in numberWordsToDigits {
        if processedLine.contains(word) {
            let replacement = String(word.first!) + digit + String(word.last!)
            processedLine = processedLine.replacingOccurrences(of: word, with: replacement)
        }
    }
    return processedLine
}

func findCalibrationValue(from line: String) -> Int? {
    let digits = line.compactMap { Int(String($0)) }
    guard let firstDigit = digits.first, let lastDigit = digits.last else { return nil }
    return firstDigit * 10 + lastDigit
}

do {
    guard let filePath = Bundle.main.path(forResource: "input", ofType: "txt") else {
        fatalError("File not found")
    }
    
    let contents = try String(contentsOfFile: filePath, encoding: .utf8)
    let lines = contents.split(separator:"\n")
    
    var sum = 0
    for line in lines {
        let processedLine = processLine(String(line))
        if let calibrationValue = findCalibrationValue(from: processedLine) {
            sum += calibrationValue
        }
    }
    
    print("Sum of calibration values: \(sum)")
    
} catch {
    print("Error reading or processing the file: \(error)")
}