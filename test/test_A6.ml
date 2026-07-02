open OUnit2
open A6.Sets
open CreateSet

let test_empty = "test suite for empty" >::: [
  "is_empty empty " >:: (fun _ -> assert_equal true (is_empty empty));
  "is_empty non-empty" >:: (fun _ -> assert_equal false (is_empty 
  (insert 4 empty)))
]

let test_mem = "test suite for mem" >::: [
  "mem x empty" >:: (fun _ -> assert_equal false (mem 3 empty));
  "mem y (insert x s) = true if x = y" >:: (fun _ -> assert_equal true 
    (mem 3 (insert 3 empty)));
  "mem y (insert x s) = mem y s if x <> y" >:: (fun _  -> assert_equal false
     (mem 2 (insert 3 empty)))
]

let first_tree = insert 12 (insert 6 (insert 4 (insert 5 empty)))

let first_expected = build_set "Black" 6 
~set_one:(build_set "Black" 5 
~set_one:(build_set "Red" 4 ()) ()) 
~set_two:(build_set "Black" 12 ())

let second_tree = insert 1 (insert 6 (insert 4 (insert 5 empty)))

let second_expected = build_set "Black" 4 
~set_one:(build_set "Black" 1 ())
~set_two:(build_set "Black" 5 () ~set_two:(build_set "Red" 6 ()))

let test_insert = "test suite for insert" >::: [ 
  "insert x empty" >:: (fun _ -> assert_equal (build_set "Black" 1 ())
   (insert 1 empty));
  "balance violate left left" >:: (fun _ -> assert_equal first_tree
   (first_expected ()));
  "balance violate right left" >:: (fun _ -> assert_equal second_tree 
  (second_expected ()));
  "balance already in set" >:: (fun _ -> assert_equal 
  (insert 1 (insert 1 empty)) (build_set "Black" 1 ()));
]

let _ = run_test_tt_main ("All_tests" >::: [test_empty; test_mem; test_insert])