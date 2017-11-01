:- dynamic frame/2.


%% network of Frames
frame(university, [(phone,(default, 011686971)),(address,(default, iitDelhi))]).
frame(department, [(a_part_of,university),(programme,(btech, mtech, ph_d))]).
frame(hostel, [(a_part_of,university), (room,(default, 100))]).
frame(faculty, [(a_part_of,department), (age,(range,25,60)),(nationality,(default, indian)),(qual,(default, postgraduate))]).
frame(nilgiri, [(is_a,hostel), (phone,011686234)]).
frame(science_faculty, [(ako,faculty),(qual,(default, msc))]).
frame(renuka, [(is_a,science_faculty),(qual,ph_d),(age,45),(address,janakpuri)]).


%% Module to insert a frame in NOF with all slot values filled up
%% Fname : Frame Name
%% Pname : Parent Name

insertframe(Fname,_,_):-frame(Fname,_),!, 
						write("\n Error- Frame: "),write(Fname),write(" Already Exists"),nl.
insertframe(Fname,Pname,List):-frame(Pname,_),assertz(frame(Fname,List)).
insertframe(_,Pname,_):-write("\n Error - Invalid Parent Name: "),write(Pname),nl. 


%% Module to delete a frame from NOF
%% Deletes the whole subtree below the frame 
deleteframe(Fname):-frame(Fname,_), frame(Y,[(a_part_of,Fname)|_]),deleteframe(Y).
deleteframe(Fname):-frame(Fname,_), frame(Y,[(ako,Fname)|_])      ,deleteframe(Y).
deleteframe(Fname):-frame(Fname,_), frame(Y,[(is_a,Fname)|_])     ,deleteframe(Y).
deleteframe(Fname):-frame(Fname,Z), write("Deleting "),write(Fname),nl, retract(frame(Fname,Z)).


%% Update the value of the slot for a given frame
update([(Slot,_)|L],Slot,Newval,[(Slot,Newval)|L]).
update([H|L],Slot,Newval,[H|NewL]):-update(L,Slot,Newval,NewL).

updateframe(Fname,Slot,Val):- 	frame(Fname,Z),!,update(Z,Slot,Val,NewZ),
								retract(frame(Fname,Z)),assertz(frame(Fname,NewZ)),
								write("\nUpdated"),nl,!.
updateframe(Fname,_,_):-write("\n Error - Invalid Frame Name: "),write(Fname),nl. 


%% Module to query FBS
search([(Slot,Val)|_],Slot,Val):-!.
search([_|List],Slot,Val):-search(List,Slot,Val).

find(X, Slot,Val) :- frame(X, Z) , 					search(Z, Slot,Val),!.
find(X, Slot,Val) :- frame(X, [(is_a,Z)|_]) , 		find(Z, Slot,Val),!.
find(X, Slot,Val) :- frame(X, [(ako,Z)|_]) , 		find(Z, Slot,Val),!.
find(X, Slot,Val) :- frame(X, [(a_part_of,Z)|_]) , 	find(Z, Slot,Val).
