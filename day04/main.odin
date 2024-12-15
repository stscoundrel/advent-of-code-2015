package day04

import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:crypto/hash"
import "core:encoding/hex"

append_number_to_string :: proc(base: string, number: int) -> string {
    // What kind of cursed foolishness is this itoa implementatio.
    buf: [10]byte
	result := strconv.itoa(buf[:], number)
    a := [?]string { base, result }
	return strings.concatenate(a[:])
}

md5_hash :: proc(input: string) -> []u8 {
    digest := hash.hash_string(hash.Algorithm.Insecure_MD5, input)        
    return hex.encode(digest)
}

solve_part_1 :: proc(input: string) -> int {
    ZERO :: 48
    count := 0
    
    for count < 1000000 {
        secret := append_number_to_string(input, count)
        md5 := md5_hash(secret)

        if(md5[0] == ZERO && md5[1] == ZERO && md5[2] == ZERO && md5[3] == ZERO && md5[4] == ZERO) {
            return count
        }

        count += 1
    }

    

    return count

}

main :: proc() {     
    testInput :: `abcdef`
    input :: "ckczppom"


    fmt.println(solve_part_1(input))
}