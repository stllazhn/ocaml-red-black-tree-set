module type SetType = sig
  type color 
  
  type 'a t 
  
  val empty : 'a t
  
  val is_empty : 'a t -> bool
  
  val mem : 'a -> 'a t -> bool
  
  val insert : 'a -> 'a t -> 'a t

  val build_set : string -> 'a -> ?set_one:'a t -> ?set_two:'a t -> unit -> 'a t
end

module CreateSet : SetType = struct
  type color = Red | Black

  (** AF: [Leaf] represents the empty set. [Node (c, v, l, r)]
      represents the set containing [v], as well as all the elements of
      the sets represented by [l] and [r]. RI: The BST invariant holds,
      and the local and global RB tree invariants hold. *)
  type 'a t = Leaf | Node of color * 'a * 'a t * 'a t

  let empty = Leaf

  let is_empty = function
  |Leaf -> true
  |_-> false

  let rec mem x = function
  | Leaf -> false
  | Node (_, y, l, r) ->
    if x < y then mem x l
    else if x > y then mem x r
    else true

  let balance = function
  | Black, z, Node (Red, y, Node (Red, x, a, b), c), d
  | Black, z, Node (Red, x, a, Node (Red, y, b, c)), d
  | Black, x, a, Node (Red, z, Node (Red, y, b, c), d)
  | Black, x, a, Node (Red, y, b, Node (Red, z, c, d)) ->
    Node (Red, y, Node (Black, x, a, b), Node (Black, z, c, d))
  | a, b, c, d -> Node (a, b, c, d)

  let insert x s =
    let rec ins = function
      | Leaf -> Node (Red, x, Leaf, Leaf)
      | Node (color, y, a, b) as s ->
        if x < y then balance (color, y, ins a, b)
        else if x > y then balance (color, y, a, ins b)
        else s
    in
    match ins s with
    | Node (_, y, a, b) -> Node (Black, y, a, b)
    | Leaf -> 
      failwith "RBT insert failed with ins returning leaf"

  let build_set (color : string) value ?(set_one=Leaf) ?(set_two=Leaf) ()=
    let node_color =
      match color with
      |"Black"->Black
      |_->Red in
    Node (node_color,value,set_one,set_two)
end