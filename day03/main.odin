package day13

import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:slice"
import "core:os"

Direction :: enum {
	Up,
	Down,
    Left,
    Right
}

Coordinate :: struct {
	x: int,
	y: int,
}

parse_input :: proc(input: string)  -> [dynamic]Direction {
    directions: [dynamic]Direction
    routes := strings.split(input, "\n")

    for route in routes {
        for part in route {
            switch part {
                case '^':
                    append(&directions, Direction.Up)                
                case 'v':
                    append(&directions, Direction.Down)
                case '>':
                    append(&directions, Direction.Right)
                case '<':
                    append(&directions, Direction.Left)
            }
        }
       
    }

    return directions
}

solve_part_1 :: proc(directions: [dynamic]Direction) -> int {
    x := 0
    y := 0
    visited: map[Coordinate]int
    visited[Coordinate{x, y}] = 1

    for direction in directions {
        switch direction {
            case Direction.Up:
                y -= 1
                visited[Coordinate{x, y}] += 1
            case Direction.Down: 
                y += 1
                visited[Coordinate{x, y}] += 1
            case Direction.Right: 
                x += 1
                visited[Coordinate{x, y}] += 1
            case Direction.Left:
                x -= 1
                visited[Coordinate{x, y}] += 1
        }
    }


    return len(visited)
}

solve_part_2 :: proc(directions: [dynamic]Direction) -> int {
    santa_x := 0
    santa_y := 0
    robo_x := 0
    robo_y := 0
    visited: map[Coordinate]int
    visited[Coordinate{santa_x, santa_y}] = 1

    for direction, index in directions {

        if(index % 2 == 0 || index == 0) {
            switch direction {
                case Direction.Up:
                    santa_y -= 1
                    visited[Coordinate{santa_x, santa_y}] += 1
                case Direction.Down: 
                    santa_y += 1
                    visited[Coordinate{santa_x, santa_y}] += 1
                case Direction.Right: 
                    santa_x += 1
                    visited[Coordinate{santa_x, santa_y}] += 1
                case Direction.Left:
                    santa_x -= 1
                    visited[Coordinate{santa_x, santa_y}] += 1
            }
        } else {
            switch direction {
                case Direction.Up:
                    robo_y -= 1
                    visited[Coordinate{robo_x, robo_y}] += 1
                case Direction.Down: 
                    robo_y += 1
                    visited[Coordinate{robo_x, robo_y}] += 1
                case Direction.Right: 
                    robo_x += 1
                    visited[Coordinate{robo_x, robo_y}] += 1
                case Direction.Left:
                    robo_x -= 1
                    visited[Coordinate{robo_x, robo_y}] += 1
            }
        }
    }


    return len(visited)
}

main :: proc() {     
    testInput :: `^v^v^v^v^v`

    raw_input, ok := os.read_entire_file("input.txt");
    input := string(raw_input)

    directions := parse_input(input)   

    fmt.println(solve_part_1(directions))
    fmt.println(solve_part_2(directions))
}