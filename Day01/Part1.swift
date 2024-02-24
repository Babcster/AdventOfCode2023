import Foundation

var sum = 0

func findFirstAndLastNumericDigit(in string: String) -> (first: Int?, last: Int?) {
    let digits = string.compactMap { $0.wholeNumberValue }
    guard let firstDigit = digits.first, let lastDigit = digits.last else {
        return (nil, nil)
    }
    return (firstDigit, lastDigit)
}

if let filePath = Bundle.main.path(forResource: "input", ofType: "txt") {
    do {
        let contents = try String(contentsOfFile: filePath, encoding: .utf8)
        let lines = contents.split(separator: "\n")
        
        for line in lines {
            let (firstDigit, lastDigit) = findFirstAndLastNumericDigit(in: String(line))
            
            if let first = firstDigit, let last = lastDigit {
                let combined = first * 10 + last
                sum += combined
            }
        }
    } catch {
        print("Error reading contents of file: \(error)")
    }
} else {
    print("File not found")
}

print("Sum of calibration values: \(sum)")