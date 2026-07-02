(** @author Juanru(Stella) Zhang (jz766) *)

open A6.Sets

let generate_list max =
  let rec aux max acc =
    if max < 0 then acc
    else aux (max - 1) (max :: acc)
  in
  aux max []

let remix_list lst =
  let len = List.length lst in
  let arr = Array.of_list lst in
  for i = len - 1 downto 1 do
    let j = Random.int (i + 1) in
    let temp = arr.(i) in
    arr.(i) <- arr.(j);
    arr.(j) <- temp;
  done;
  Array.to_list arr

let rec get_element (index : int) lst = 
  match lst with
  | [] -> failwith "No elements in list"
  | h :: t -> if index = 0 then h else get_element (index - 1) t

let n = [400000; 700000; 900000; 1200000; 2746666; 5093333; 7440000; 9786666; 
12133333; 14500000; 16866666; 19233333; 21600000; 23966666; 27333333; 31700000;
36066666; 40000000]

let repeated_inserts lst number_inserted set =
  let rec rep remaining_list remaining_insertions set =
    if remaining_insertions = 0 then set
    else
      match remaining_list with 
      | [] -> set
      | h :: t -> rep t (remaining_insertions - 1) (CreateSet.insert h set)
  in
  rep lst number_inserted set

let time f x y z =
  let start = Unix.gettimeofday () in
  let _ = f x y z in
  let stop = Unix.gettimeofday () in
  stop -. start 
   
let unique_list = remix_list (generate_list 55000000)

let () = 
print_endline "n,nlogn,Time";
for i=0 to (List.length n-1) do
  let n_trial = get_element i n in
  let list_medians =
    let rec loop num_samples acc =
      if num_samples <= 0 then acc
      else
        let total_time = time repeated_inserts unique_list n_trial 
        CreateSet.empty in
        loop (num_samples - 1) (total_time :: acc)
    in
    List.sort compare (loop 3 []) in
  Printf.printf "%d,%f,%f\n" n_trial ((float n_trial)*.log10 (float n_trial)) 
  (get_element 1 list_medians);
  flush stdout;
done;




