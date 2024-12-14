package day13

import "core:fmt"
import "core:strings"
import "core:os"

Direction :: enum {
	Up,
	Down,
}



parse_input :: proc(input: string) -> [dynamic]Direction {
    directions: [dynamic]Direction
    parts := strings.split(input, "")

    for part in parts {
        switch part {
            case "(":
                append(&directions, Direction.Up)
            case ")":
                append(&directions, Direction.Down)
        }
    }

    return directions
}

solve_part_1 :: proc(directions: [dynamic]Direction) -> int {
    floor := 0

    for direction in directions {
        switch direction {
            case Direction.Up:
                floor += 1
            case Direction.Down:
                floor -= 1
        }
    }

    return floor
}

solve_part_2 :: proc(directions: [dynamic]Direction) -> int {
    floor := 0

    for direction, idx in directions {
        switch direction {
            case Direction.Up:
                floor += 1
            case Direction.Down:
                floor -= 1
        }

        if floor == -1 {
            return idx + 1
        }
    }

    return floor
}

main :: proc() {     
    testInput :: `)())())`

    raw_input, ok := os.read_entire_file("input.txt");
    input := string(raw_input)

    directions := parse_input(input)    

    fmt.println(solve_part_1(directions))
    fmt.println(solve_part_2(directions))
}