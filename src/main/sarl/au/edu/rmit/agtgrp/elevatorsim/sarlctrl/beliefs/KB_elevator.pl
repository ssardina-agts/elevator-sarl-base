/** 
 * SARL-Prolog-Elevator - Elevator controller for the SARL Elevator
 * Simulator with Prolog-based theoretical reasoning capabilities
 * Copyright (C) 2017 Matthew McNally.

 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.

 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.

 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

/**
 * sweeper_elevator_agent
 * Beliefs held by a Sweeper Elevator Agent in terms of which
 * open car or floor requests to handle at any one time during
 * the simulation
 */

:- dynamic
	car_arrived/3.


get_iso_time(T) :-
    get_time(X), 
    format_time(atom(T),'%Y-%m-%d--%H:%M:%S',X,posix).

%save_db(ID) :-
%	(var(ID) -> ID = default ; true),
%	string_to_atom(SID, ID),
%	get_iso_time(T), !,
%	strings_concat(["kb-", SID, "-", T, ".pl"], FileName),
%	open(FileName, write, F), 
%	set_output(F), 
%	listing,
%	close(F).
	
	
	
% Concatenate a list of strings
strings_concat([], "").
strings_concat([S|L], CS) :-
	strings_concat(L, CS2),
	string_concat(S, CS2, CS).


/**
 * direction(-Direction:atom) is semidet.
 *
 * Represents a valid elevator travel direction.
 */
direction(up).
direction(down).

