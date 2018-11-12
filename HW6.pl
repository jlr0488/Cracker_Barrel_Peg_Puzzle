%This prolog program finds all solutions to the Cracker Barrel Peg Puzzle for all empty peg positions 0-4


% List of all valid moves in the following form: moves(From, Over, To) where From = starting peg location, Over = peg to be rid of that is adjacent to From, To = destination of peg in starting location 
move(From,1,To):- member([From,To], [[0,3], [3,0]]).
move(From,2,To):- member([From,To], [[0,5], [5,0]]).
move(From,3,To):- member([From,To], [[1,6], [6,1]]).
move(From,4,To):- member([From,To], [[1,8], [8,1]]).
move(From,4,To):- member([From,To], [[2,7], [7,2]]).
move(From,5,To):- member([From,To], [[2,9], [9,2]]).
move(From,6,To):- member([From,To], [[3,10], [10,3]]).
move(From,7,To):- member([From,To], [[3,12], [12,3]]).
move(From,7,To):- member([From,To], [[4,11], [11,4]]).
move(From,8,To):- member([From,To], [[4,13], [13,4]]).
move(From,8,To):- member([From,To], [[5,12], [12,5]]).
move(From,9,To):- member([From,To], [[5,14], [14,5]]).
move(From,4,To):- member([From,To], [[3,5], [5,3]]).
move(From,7,To):- member([From,To], [[6,8], [8,6]]).
move(From,8,To):- member([From,To], [[7,9], [9,7]]).
move(From,11,To):- member([From,To], [[10,12], [12,10]]).
move(From,12,To):- member([From,To], [[11,13], [13,11]]).
move(From,13,To):- member([From,To], [[12,14], [14,12]]).

:- use_module(library(lambda)).

% This function is the starting point of the program and finds all solutions where the starting empty cell position is in positions 0-4
go :-
	soln0,
	soln1,
	soln2,
	soln3,
	soln4.

% Recursively makes moves on the peg board
do_move(_, [_], Lst, Moves) :-
	reverse(Lst, Moves).

% Empty is the current location of a blank cell & Full is a list of all the cells with pegs  
do_move(Empty, Full, Lst, Moves) :-
	% Full_2 is Full minus the From element
	select(From, Full, Full_2),
	% Full_3 is Full_2 minus the Over element
	select(Over, Full_2, Full_3),
	% Empty_2 is Free minus the To element
	select(To, Empty, Empty_2),
	% check to see if this is a valid move
	move(From, Over, To),
	% if valid move, make that move
	do_move([From, Over | Empty_2], [To | Full_3], [move(From,Over,To) | Lst], Moves).
 

% Shows results of the current solution
show_board([], Empty) :-
	% create list with 15 elements
	numlist(0,14, Lst),
	% all cells in the Empty list are assigned '.' while all other cells are labeled 'x'
	maplist(\X^L^(member(X, Empty) -> L = '.'; L = 'x'), Lst,
	[L0,L1,L2,L3,L4,L5,L6,L7,L8,L9,L10,L11,L12,L13,L14]),
        format('    ~w        ', [L0]), nl,
        format('   ~w ~w      ', [L1,L2]), nl,
        format('  ~w ~w ~w    ', [L3,L4,L5]), nl,
        format(' ~w ~w ~w ~w  ', [L6,L7,L8,L9]), nl,
        format('~w ~w ~w ~w ~w', [L10,L11,L12,L13,L14]), nl. 

% Recursively prints board with filled in cell positions of the current solution
show_board([move(From, Over, To) | Tail], Empty) :-
	numlist(0,14, Lst),
	maplist(\X^L^(member(X, Empty) -> L = '.'; L = 'x'), Lst, 
	[L0,L1,L2,L3,L4,L5,L6,L7,L8,L9,L10,L11,L12,L13,L14]),
	format('    ~w        ', [L0]), nl,
	format('   ~w ~w      ', [L1,L2]), nl,
	format('  ~w ~w ~w    ', [L3,L4,L5]), nl,
	format(' ~w ~w ~w ~w  ', [L6,L7,L8,L9]), nl,
	format('~w ~w ~w ~w ~w', [L10,L11,L12,L13,L14]), nl, nl,
	select(To, Empty, Empty_2),
	show_board(Tail,  [From, Over | Empty_2]).

% Runs solution from empty cell 0
soln0 :-
        nl,
        write("+------ Solution 0 ------+"),
        nl,
        do_move([0], [1,2,3,4,5,6,7,8,9,10,11,12,13,14], [], Moves),
        show_board(Moves, [0]).

% Runs solution from empty cell 1
soln1 :-
        nl,
        write("+------ Solution 1 ------+"),
        nl,
        do_move([1], [0,2,3,4,5,6,7,8,9,10,11,12,13,14], [], Moves),
        show_board(Moves, [1]).

% Runs solution from empty cell 2
soln2 :-
        nl,
        write("+------ Solution 2 ------+"),
        nl,
        do_move([2], [0,1,3,4,5,6,7,8,9,10,11,12,13,14], [], Moves),
        show_board(Moves, [2]).

% Runs solution from empty cell 3
soln3 :-
        nl,
        write("+------ Solution 3 ------+"),
        nl,
        do_move([3], [0,1,2,4,5,6,7,8,9,10,11,12,13,14], [], Moves),
        show_board(Moves, [3]).

% Runs solution from empty cell 4
soln4 :-
        nl,
        write("+------ Solution 4 ------+"),
        nl,
        do_move([4], [0,1,2,3,5,6,7,8,9,10,11,12,13,14], [], Moves),
        show_board(Moves, [4]).

