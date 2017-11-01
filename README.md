# Frame Based System

This is an implementation of a frame based system for represetation of data pertaining to a university/hospital. The example we have chosen is that of a university.

# How to run

You should have Prolog (say swi-Prolog) installed. Open a terminal at the location of the source code, and enter:

	swipl frames.pl

Then, you can query the slot values of frames, insert new frames, delete entire subtrees of frames or update the slot values of frames.

To insert a new frame with name Fname, parent Pname and list of slot-value pairs L, give the command:
	
	:- insertframe(Frame_name, Parent_frame_name, List of slot facet pairs).

If the frame already exists, or the parent does not exist, an error will occur.

To delete a frame and its subtree, give the command:

	:- delete(Frame_name).

To update slot S of a frame F with value V, give the command:

	:- updateframe(F, S, V).

The slot can be even that which belongs to an ancestor (in the network of frames) of the frame F.

To find the value V of a slot S for frame F, give the command:
	
	:- find(F, S, V).

If the frame or the required slot does not exist, an error is returned.
