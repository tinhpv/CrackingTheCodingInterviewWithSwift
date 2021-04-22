import UIKit

/*
 Langton's Ant: An ant is sitting on an infinite grid of white and black squares. It initially faces right.
 At each step, it does the following:
 (1) At a white square, flip the color of the square, turn 90 degrees right (clockwise), and move forward one unit.
 (2) At a black square, flip the color of the square, turn 90 degrees left (counter-clockwise), and move forward one unit.
 Write a program to simulate the first K moves that the ant makes and print the final board as a grid. Note that you are not provided with the data structure to represent the grid. This is something you must design yourself. The only input to your method is K. You should print the final grid and return nothing.Themethodsignaturemightbesomethinglikevoid printKMoves(int K).
 */


class Grid {
    var grid:[[Int]] = [[0]]
    var height:Int { return grid.count }
    var width:Int { return grid.first!.count }
    
    func flip(_ row:Int, _ col:Int) {
        grid[row][col] = grid[row][col] == 0 ? 1 : 0
    }
    
    func resize(for ant:Ant) {
        let h = height
        let w = width
        
        switch (ant.row, ant.col) {
        case (-1, _): //top
            grid.insert(Array(repeating: 0, count: w), at: 0)
            ant.row += 1
        case (_, -1): //left
            for row in 0..<h { grid[row].insert(0, at: 0)}
            ant.col += 1
        case(h, _): //bottom
            grid.append(Array(repeating: 0, count: w))
        case(_, w)://right
            for row in 0..<h { grid[row].append(0) }
        default:
            break
        }
    }
    
    func printBoard() -> String {
        let rows = grid.map { $0.map(String.init).joined(separator: "")}
        return rows.joined(separator: "\n")
    }
}

class Ant {
    var row = 0
    var col = 0
    var dir = Direction.right
    
    func move() {
        switch dir {
        case .up:
            row -= 1
        case .down:
            row += 1
        case .right:
            col += 1
        case .left:
            col -= 1
        }
    }
    func turnRight() { dir = dir.turnRight() }
    func turnLeft() { dir = dir.turnLeft() }
}
enum Direction {
    case up, right, down, left
    
    func turnRight() -> Direction {
        switch self {
        case .up:
            return .right
        case .right:
            return .down
        case .down:
            return .left
        case .left:
            return .up
        }
    }
    
    func turnLeft() -> Direction {
        switch self {
        case .up:
            return .left
        case .right:
            return .up
        case .down:
            return .right
        case .left:
            return .down
        }
    }
}


func printAnt(moves:Int) -> String {
    let grid = Grid()
    let ant = Ant()
    
    for _ in 0..<moves {
        let row = ant.row
        let col = ant.col
        
        let element = grid.grid[row][col]
        grid.flip(row, col)
        
        (element == 0) ? ant.turnRight() : ant.turnLeft()
        
        ant.move()
        grid.resize(for: ant)
    }
    
    return grid.printBoard()
}

printAnt(moves: 5)
