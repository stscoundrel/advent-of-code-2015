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


main :: proc() {     
    testInput :: `)())())`

    raw_input, ok := os.read_entire_file("input.txt");
    input := string(raw_input)

    directions := parse_input(input)
    floor := 0

    for direction in directions {
        switch direction {
            case Direction.Up:
                floor += 1
            case Direction.Down:
                floor -= 1
        }
    }

    fmt.println(floor)
}