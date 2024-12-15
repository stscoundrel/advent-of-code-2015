package day05

import "core:fmt"
import "core:strings"
import "core:os"
import "core:unicode/utf8"


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

solve_part_2 :: proc(input: []string) -> int {
    nice_lines := 0
    
    for line in input {
        before_previous := 'ä'
        previous := 'ö'
        had_valid_doubles := false
        had_valid_between_repeat := false

        for letter, index in line {
            substr := utf8.runes_to_string([]rune{previous, letter})
            instances := strings.count(line, substr)
            
            if instances > 1 {
                had_valid_doubles = true
            }            
            
            if before_previous == letter {
                had_valid_between_repeat = true
            }

            before_previous = previous
            previous = letter
        }

        if had_valid_doubles && had_valid_between_repeat {
            nice_lines += 1
        }
    }

    return nice_lines
}


main :: proc() {     
    testInput :: []string{"qjhvhtzxzqqjkmpb", "xxyxx", "uurcxstgmygtbstg", "ieodomkazucvgmuy"}
    
    raw_input, ok := os.read_entire_file("input.txt");
    input := parse_input(string(raw_input))

    fmt.println(solve_part_1(input))
    fmt.println(solve_part_2(input))
}