frame(university, [phone(default, 011686971),address(default, iitDelhi)]).
frame(department, [a_part_of(university),programme([btech, mtech, ph_d])]).
frame(hostel, [a_part_of(university), room(default, 100)]).
frame(faculty, [a_part_of(department), age(range,25,60),nationality(default, indian), qual(default, postgraduate)]).
frame(nilgiri, [is_a(hostel), phone(011686234)]).
frame(science_faculty, [ako(faculty),qual(default, msc)]).
frame(renuka, [is_a(science_faculty), qual(ph_d),age(45), address(janakpuri)]).


search([H|_],Y,X):-H=call(Y,X).
search([_|Z],Y,A):-search(Z,Y,A).

find(X, Y, A) :- frame(X, Z), search(Z, Y, A), !.
find(X, Y, A) :- frame(X, [is_a(Z),_]), find(Z, Y, A), !.
find(X, Y, A) :- frame(X, [ako(Z), _]), find(Z, Y, A), !.
find(X, Y, A) :- frame(X, [a_part_of(Z), _]), find(Z, Y, A).

insertframe(F_name,_,_):-frame(F_name,_), write("\n Error -Frame:",F_name,"Already Exists").
insertframe(F_name,Par_name,L):-frame(Par_name,_),asserta(frame(F_name,L)).
insertframe(F_name,_,_):-write("\n Error - Possibly invalid Parent Name:",F_name). 


deleteframe(F_name):-frame(F_name,Z),!, retract(frame(F_name,Z)),frame(Y,[a_part_of(F_name),_]),deleteframe(Y).
deleteframe(F_name):-frame(F_name,Z),!, retract(frame(F_name,Z)),frame(Y,[is_a(F_name),_]),deleteframe(Y).
deleteframe(F_name):-frame(F_name,Z),!, retract(frame(F_name,Z)),frame(Y,[ako(F_name),_]),deleteframe(Y).
deleteframe(F_name):-write("\n Error -Frame:",F_name,"Doesn't Exist").
