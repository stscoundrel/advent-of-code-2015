package day06

import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:os"

Command :: enum {
    TurnOn,
    TurnOff,
    Toggle
}

Coordinate :: struct {
    x: int,
    y: int
}

Instruction :: struct {
	command: Command,
	start: Coordinate,
    end: Coordinate,
}

get_coordinate :: proc(line: string) -> Coordinate {
    parts := strings.split(line, ",")

    return Coordinate{
        strconv.atoi(parts[0]),
        strconv.atoi(parts[1]),
    }
}

parse_input :: proc(input: string)  -> []Instruction {
    lines := strings.split(input, "\n")
    instructions := make([]Instruction, len(lines))

    for line, index in lines {
        if strings.count(line, "turn on") > 0 {
            parts := strings.split(line, " ")

            start := get_coordinate(parts[2])
            end := get_coordinate(parts[4])

            instructions[index] = Instruction{ Command.TurnOn, start, end }
        }

        if strings.count(line, "turn off") > 0 {
            parts := strings.split(line, " ")

            start := get_coordinate(parts[2])
            end := get_coordinate(parts[4])

            instructions[index] = Instruction{ Command.TurnOff, start, end }
        }

        if strings.count(line, "toggle") > 0 {
            parts := strings.split(line, " ")

            start := get_coordinate(parts[1])
            end := get_coordinate(parts[3])

            instructions[index] = Instruction{ Command.Toggle, start, end }
        }
    }

    return instructions
}

get_grid :: proc() -> [][]bool {
    grid := make([][]bool, 1000)

    for row, index in grid {
        data := make([]bool, 1000)
        grid[index] = data
    }

    return grid
}

count_lights :: proc(grid: [][]bool) -> int {
    sum := 0

    for row in grid {
        for light in row {
            if light == true { sum += 1 }
        }
    }

    return sum
}

solve_part_1 :: proc(instructions: []Instruction) -> int {
    lights := 0
    grid := get_grid()   

    for instruction in instructions {
        for x in instruction.start.x..=instruction.end.x {
            for y in instruction.start.y..=instruction.end.y {
                switch instruction.command {
                    case Command.TurnOn:
                        grid[x][y] = true
                    case Command.TurnOff:
                        grid[x][y] = false
                    case Command.Toggle:
                        grid[x][y] = !grid[x][y]
                }
            }
        }   
    }

    return count_lights(grid)
}



main :: proc() {         
    raw_input, ok := os.read_entire_file("input.txt");
    input := parse_input(string(raw_input))    

    fmt.println(solve_part_1(input))
}