/*
/// Module: workshop_nft
module workshop_nft::workshop_nft;
*/

// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions

module workshop_nft::workshop_nft;

use std::string;
use sui::url::{Self, Url};


public struct NFT has key, store {
    id: UID,
    name: string::String,
    description: string::String,
    url: Url,
}

public entry fun mint(
    name: vector<u8>,
    description: vector<u8>,
    url: vector<u8>,
    ctx: &mut TxContext,
) {
    let sender = ctx.sender();
    let nft = NFT {
        id: object::new(ctx),
        name: string::utf8(name),
        description: string::utf8(description),
        url: url::new_unsafe_from_bytes(url),
    };
    transfer::public_transfer(nft, sender);
}

public entry fun transfer(nft: NFT, recipient: address, _: &mut TxContext)
{
    transfer::public_transfer(nft, recipient);
}

