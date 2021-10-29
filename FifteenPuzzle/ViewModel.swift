//
//  ViewModel.swift
//  FifteenPuzzle
//
//  Created by Miroslav Kutak on 10/28/2021.
//

import Combine

class FifteenPuzzleModel: ObservableObject {
    @Published var matrix = [PuzzleColumn].init(repeating: PuzzleColumn(values: [PuzzleValue].init(repeating: PuzzleValue(value: 0), count: 4)), count: 4)

    init() {
        sort()
    }

    func sort() {
        let values = Array(0..<16)
        setValuesArray(values)
    }

    func shuffle() {
        let values = (0..<16).shuffled()
        setValuesArray(values)
    }

    private func setValuesArray(_ values: [Int]) {
        iterate { point, index in
            setValue(values[index], at: point)
        }
    }

    var intValues: [Int] {
        var values = [Int].init(repeating: 0, count: 16)
        iterate { point, index in
            values[index] = value(at: point)
        }
        return values
    }

    private func iterate(_ block: (_ point: Coordinate, _ index: Int) -> Void) {
        for x in 0..<4 {
            for y in 0..<4 {
                let index = y * 4 + x
                if let point = Coordinate(x: x, y: y) {
                    block(point, index)
                }
            }
        }
    }

    var isSorted: Bool {
        return Array(0..<16) == intValues
    }

    /**
     Return true if the move was successful
     */
    @discardableResult
    func move(from pointFrom: Coordinate, direction: MoveDirection) -> Bool {
        // Ensure there is a value at the starting position (we cannot move an empty field)
        let fromValue = value(at: pointFrom)
        guard fromValue > 0 else { return false }
        // Ensure there is a place to move to
        guard let pointTo = point(nextTo: pointFrom, in: direction) else { return false }
        // Ensure the place to move to is empty
        guard value(at: pointTo) == 0 else { return false }

        // Perform the actual movement
        setValue(0, at: pointFrom)
        setValue(fromValue, at: pointTo)
        return true
    }

    private func point(nextTo point: Coordinate, in direction: MoveDirection) -> Coordinate? {
        switch direction {
        case .up:
            return Coordinate(x: point.x, y: point.y - 1)
        case .left:
            return Coordinate(x: point.x - 1, y: point.y)
        case .down:
            return Coordinate(x: point.x, y: point.y + 1)
        case .right:
            return Coordinate(x: point.x + 1, y: point.y)
        }
    }

    private func value(at point: Coordinate) -> Int {
        return matrix[point.x].values[point.y].value
    }

    private func setValue(_ value: Int, at point: Coordinate) {
        matrix[point.x].values[point.y] = PuzzleValue(value: value)
    }
}
