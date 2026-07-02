(** Module type to represent a set. *)
module type SetType = sig
    (** Type to represent colors used in the set. *)
    type color 

    (** Type to represent a set. *)
    type 'a t 

    (** [empty] is an empty red-black set. *)
    val empty : 'a t

    (** [is_empty 'a t] checks if the set ['a t] is empty. *)
    val is_empty : 'a t -> bool

    (** [mem x 'a t] checks if the value [x] is a member of the set ['a t]. *)
    val mem : 'a -> 'a t -> bool

    (** [insert x s] inserts the value [x] into the set [s] 
        and maintains the set's properties. *)
    val insert : 'a -> 'a t -> 'a t

    (** [build_set color value set_one set_two] creates a set with [color], 
        [set_one], [value], and [set_two]*)
    val build_set: string -> 'a -> ?set_one:'a t -> ?set_two:'a t -> unit
     -> 'a t
end

module CreateSet : SetType