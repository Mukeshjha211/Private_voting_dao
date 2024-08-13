
import "std/console.leo";

struct Vote {
    candidate: u8, 
}

mapping votes: address => Vote;

function cast_vote(candidate: u8) -> bool {
    assert(candidate == 0u8 || candidate == 1u8);

    let voter_address = get_caller(); 
    let vote = Vote { candidate };
    votes[voter_address] = vote;

    true
}

function tally_votes() -> u8 {
    let mut count_candidate_0 = 0u8;
    let mut count_candidate_1 = 0u8;

    for (voter_address, vote) in votes.iter() {
        match vote.candidate {
            0u8 => count_candidate_0 += 1u8,
            1u8 => count_candidate_1 += 1u8,
            _ => console::error("Invalid candidate"),
        }
    }

    if count_candidate_1 > count_candidate_0 {
        1u8
    } else {
        0u8
    }
}

function main() {
    cast_vote(0u8); 
    cast_vote(1u8); 
    cast_vote(1u8); 

    let winner = tally_votes();
    console::log("The winner is: ", winner);
}
