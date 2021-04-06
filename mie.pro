% Start rules (Knowledge base)
/* knowledge base */

mie(la_fonte):-
    orang_indonesia(tidak).

mie(Samyang):-
    orang_indonesia(tidak).
    rakyat_jelata(tidak).
    
mie(UFO):-
    orang_indonesia(tidak).
    rakyat_jelata(iya).    

mie(lemonilo):-
    orang_indonesia(iya),
    rakyat_jelata(tidak).

mie(indomie):-
    orang_indonesia(iya),
    rakyat_jelata(iya),
    beragama_indomie(iya).

mie(sedap):-
    orang_indonesia(iya),
    rakyat_jelata(iya),
    beragama_indomie(tidak),
    penyuka_mi_sedap(iya).

mie(sakura):-
    orang_indonesia(iya),
    rakyat_jelata(iya),
    beragama_indomie(tidak),
    penyuka_mi_sedap(tidak),
    ingin_bernostalgia(iya).

mie(sarimi):-
    orang_indonesia(iya),
    rakyat_jelata(iya),
    beragama_indomie(tidak),
    penyuka_mi_sedap(tidak),
    ingin_bernostalgia(tidak).

% Start User Interface
/* Asking the user */
orang_indonesia(X):-
    menuask(orang_indonesia, X, [iya, tidak]).

rakyat_jelata(X):-
    menuask(rakyat_jelata, X, [iya, tidak]).

beragama_indomie(X):-
    menuask(beragama_indomie, X, [iya, tidak]).

penyuka_mi_sedap(X):-
    menuask(penyuka_mi_sedap, X, [iya, tidak]).

ingin_bernostalgia(X):-
    menuask(ingin_bernostalgia, X, [iya, tidak]).

/* Menus for user & Remembering the answer*/
menuask(A, V, _):-
    known(iya, A, V), % succeed if true
    !. % stop looking
menuask(A, V, _):-
    known(_, A, V), % fail if false
    !,
    fail.
menuask(A, V, MenuList) :-
    write('Apakah anda '), write(A), write('?'), nl,
    write(MenuList), nl,
    read(X),
    check_val(X, A, V, MenuList),
    asserta( known(iya, A, X) ),
    X == V. 

/* Check input */
check_val(X, _A, _V, MenuList) :-
    member(X, MenuList),
    !.
check_val(X, A, V, MenuList) :-
    write(X), write(' bukan nilai baku, coba lagi.'), nl,
    menuask(A, V, MenuList).

/* Member rules */
member(X,[X|_]).
member(X,[_|T]):-member(X,T).
% End User Interface

% Start Simple Shell
/* Simple shell */
top_goal(X) :- mie(X). 

solve :-
    abolish(known, 3),
    top_goal(X),
    write('Mie yang cocok untuk anda adalah '), write(X), nl.
solve :-
    write('Mie yang kita sarankan tidak ada yang cocok dengan pilihan anda.'), nl. 

/* Command loop */
go :-  
    greeting,
    repeat,
    write('> '),
    read(X),
    do(X),
    X == berhenti.

greeting :-
    write('Ini adalah panduan untuk membeli mie instan.'), nl,
    write('Ketik mulai atau berhenti untuk memulai panduan atau tidak.'), nl.

/* Running Program */
do(mulai) :-
    solve,
    !. 

/* Quit Program */
do(berhenti).
do(X) :-
    write(X),
    write(' bukanlah perintah yang baku.'), nl,
    fail. 
% End Simple Shell

/* handle undefined procedure */
:- unknown(trace, fail).
