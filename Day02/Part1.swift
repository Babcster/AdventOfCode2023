import Foundation

// Define a struct to hold each game's data
struct Game {
    let id: Int
    let sets: [String]
}

// Function to parse the contents of the file into an array of Game structs
func parseGames(fromContents contents: String) -> [Game] {
    return contents.split(separator: "\n").compactMap { line in
        let parts = line.split(separator: ":").map { String($0) }
        if parts.count == 2, let id = Int(parts[0].split(separator: " ")[1]) {
            let sets = parts[1].split(separator: ";").map { String($0.trimmingCharacters(in: .whitespaces)) }
            return Game(id: id, sets: sets)
        }
        return nil
    }
}

guard let filePath = Bundle.main.path(forResource: "input", ofType: "txt") else {
    fatalError("File not found")
}

// Try to read the contents of the file
do {
    let contents = try String(contentsOfFile: filePath, encoding: .utf8)
    let games = parseGames(fromContents: contents)
    
    // Configuration of cubes in the bag
    let bagConfig: [String: Int] = ["red": 12, "green": 13, "blue": 14]
    
    // Function to check if the game is possible
    func isGamePossible(game: Game, bagConfig: [String: Int]) -> Bool {
        var setCounts: [String: Int] = ["red": 0, "green": 0, "blue": 0]
        
        for set in game.sets {
            let colors = set.split(separator: ",")
            for colorCount in colors {
                let parts = colorCount.trimmingCharacters(in: .whitespaces).split(separator: " ")
                if parts.count == 2, let count = Int(parts[0]) {
                    let color = String(parts[1]).lowercased()
                    setCounts[color] = max(setCounts[color]!, count)
                }
            }
        }
        
        for (color, maxCount) in setCounts {
            if maxCount > bagConfig[color, default: 0] {
                return false
            }
        }
        
        return true
    }
    
    // Determine which games are possible and sum their IDs
    let possibleGames = games.filter { isGamePossible(game: $0, bagConfig: bagConfig) }
    let sumOfIDs = possibleGames.reduce(0) { $0 + $1.id }
    
    print("Possible Games: \(possibleGames.map { $0.id })")
    print("Sum of IDs: \(sumOfIDs)")
} catch {
    print("Error reading from file: \(error)")
}