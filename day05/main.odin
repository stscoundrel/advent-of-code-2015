package day05

import "core:fmt"
import "core:strings"
import "core:os"


parse_input :: proc(input: string)  -> []string {
    return strings.split(input, "\n")
}

is_vowel :: proc(letter: rune) -> bool {
    if letter == 'a' {
        return true
    }

    if letter == 'e' {
        return true
    }

    if letter == 'i' {
        return true
    }

    if letter == 'o' {
        return true
    }

    if letter == 'u' {
        return true
    }

    return false
}

contains_forbidden :: proc(line: string) -> bool {
    if strings.count(line, "ab") > 0 {
        return true
    }

    if strings.count(line, "cd") > 0 {
        return true
    }

    if strings.count(line, "pq") > 0 {
        return true
    }

    if strings.count(line, "xy") > 0 {
        return true
    }

    return false
}

solve_part_1 :: proc(input: []string) -> int {
    nice_lines := 0
    
    for line in input {
        previous: rune
        vowels := 0
        had_doubles := false
        had_forbidden := false

        for letter, index in line {
            if index == 0 {
                previous = letter

                if is_vowel(letter) {
                    vowels += 1
                }
                continue
            }

            if is_vowel(letter) {
                vowels += 1
            }

            if contains_forbidden(line) {
                had_forbidden = true
            }

            if letter == previous {
                had_doubles = true
            }
            previous = letter
        }

        if vowels > 2 && had_doubles == true && had_forbidden == false {
            nice_lines += 1
        }
    }


    return nice_lines
}


main :: proc() {     
    testInput :: []string{"ugknbfddgicrmopn", "aaa", "jchzalrnumimnmhp", "haegwjzuvuyypxyu", "dvszwmarrgswjxmb"}
    
    raw_input, ok := os.read_entire_file("input.txt");
    input := parse_input(string(raw_input))

    fmt.println(solve_part_1(input))
}