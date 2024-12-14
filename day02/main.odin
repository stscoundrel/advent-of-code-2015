package day13

import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:slice"
import "core:os"

Dimensions :: struct {
	length: int,
	width: int,
    height: int,
}

parse_input :: proc(input: string)  -> [dynamic]Dimensions {
    dimensions: [dynamic]Dimensions
    gifts := strings.split(input, "\n")

    for gift in gifts {
        parts := strings.split(gift, "x")

        append(&dimensions, Dimensions{ strconv.atoi(parts[0]), strconv.atoi(parts[1]), strconv.atoi(parts[2])})
    }

    return dimensions
}

solve_part_1 :: proc(dimensions: [dynamic]Dimensions) -> int {
    total := 0

    for gift in dimensions {
        lengthWidth := gift.length * gift.width
        widthHeight := gift.width * gift.height
        heightLength := gift.height * gift.length

        s := []int{lengthWidth, widthHeight, heightLength}
        slice.sort(s)

        total += (2 * lengthWidth) + (2 * widthHeight) + (2 * heightLength)
        total += s[0]
    }

    return total
}

main :: proc() {     
    testInput :: `1x1x10
2x3x4`

    raw_input, ok := os.read_entire_file("input.txt");
    input := string(raw_input)

    dimensions := parse_input(input)   

    fmt.println(solve_part_1(dimensions))
}