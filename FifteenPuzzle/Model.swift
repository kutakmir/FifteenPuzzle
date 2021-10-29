//
//  Model.swift
//  FifteenPuzzle
//
//  Created by Miroslav Kutak on 10/28/2021.
//

import Foundation

enum MoveDirection {
    case up, left, down, right
}

struct Coordinate {
    let x: Int
    let y: Int

    init?(x: Int, y: Int) {
        // Make sure it's a valid coordinate
        guard x >= 0, x < 4, y >= 0, y < 4 else { return nil }
        self.x = x
        self.y = y
    }
}

struct PuzzleValue: Identifiable {
    let value: Int
    // Identifiable
    var id: Int { value }
}

extension PuzzleValue: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self.init(value: value)
    }
}

struct PuzzleColumn: Identifiable {
    var id: String = UUID().uuidString
    var values: [PuzzleValue]
}
