% =====================
% PARTE 1 - PERSONAS
% =====================

% Hechos de persona
persona(ana, 29, ingeniera).
persona(juan, 33, medico).
persona(luis, 25, estudiante).
persona(maria, 40, profesora).
persona(carla, 29, ingeniera).
persona(roberto, 45, medico).
persona(elena, 31, ingeniera).

% Hechos de amistad (solo en una dirección, el código las hace bidireccionales)
amigos(ana, juan).
amigos(juan, luis).
amigos(luis, carla).
amigos(maria, ana).
amigos(carla, elena).
amigos(elena, roberto).

% Amistad bidireccional automática
son_amigos(X, Y) :- amigos(X, Y) ; amigos(Y, X).

% ==== Primera etapa ====
personas_con_edad(Edad, Nombre) :-
    persona(Nombre, Edad, _).

profesion_de(Nombre, Profesion) :-
    persona(Nombre, _, Profesion).

amigos_de(Nombre, Amigo) :-
    son_amigos(Nombre, Amigo).

% ==== Segunda etapa ====
ingeniera_o_profesora(Nombre) :-
    persona(Nombre, _, ingeniera);
    persona(Nombre, _, profesora).

estudiante_o_40(Nombre) :-
    persona(Nombre, _, estudiante);
    persona(Nombre, 40, _).

% ==== Tercera etapa ====
% Conexión con máximo de 2 intermediarios (distancia ≤ 3)
conectado(X, Y) :- son_amigos(X, Y).
conectado(X, Y) :- son_amigos(X, Z), son_amigos(Z, Y), X \= Y.
conectado(X, Y) :- son_amigos(X, Z), son_amigos(Z, W), son_amigos(W, Y), X \= Y.

% ==== Cuarta etapa ====
ingeniera_o_medica(Nombre) :-
    persona(Nombre, _, ingeniera);
    persona(Nombre, _, medico).

mayores_de_30(Nombre) :-
    persona(Nombre, Edad, _),
    Edad > 30.

medico_amigo_de_ingeniero(Medico, Ingeniero) :-
    persona(Medico, _, medico),
    persona(Ingeniero, _, ingeniera),
    son_amigos(Medico, Ingeniero).

% =====================
% PARTE 2 - PARTIDOS
% =====================

% Hechos de partidos
partido(a, brasil, 3, croacia, 1).
partido(a, mexico, 1, camerun, 0).
partido(a, brasil, 0, mexico, 0).
partido(a, camerun, 0, croacia, 4).
partido(a, camerun, 1, brasil, 4).
partido(a, croacia, 1, mexico, 3).

partido(b, espana, 1, holanda, 5).
partido(b, chile, 3, australia, 1).
partido(b, australia, 2, holanda, 3).
partido(b, espana, 0, chile, 2).
partido(b, holanda, 2, chile, 0).
partido(b, australia, 0, espana, 3).

partido(d, uruguay, 1, costa_rica, 3).
partido(d, inglaterra, 1, italia, 2).
partido(d, uruguay, 2, inglaterra, 1).
partido(d, italia, 0, costa_rica, 1).
partido(d, italia, 0, uruguay, 1).
partido(d, costa_rica, 0, inglaterra, 0).

partido(c, colombia, 3, grecia, 0).
partido(c, japon, 1, costa_de_marfil, 2).
partido(c, colombia, 2, costa_de_marfil, 1).
partido(c, japon, 0, grecia, 0).

% ==== Primera etapa ====
goles_mexico_primer_partido(G) :-
    partido(_, mexico, G, _, _).

equipos_grupo_d(Equipo) :-
    partido(d, Equipo, _, _, _);
    partido(d, _, _, Equipo, _).

% ==== Segunda etapa ====
equipo_mas_de_3_goles(Equipo) :-
    partido(_, Equipo, G, _, _), G >= 3;
    partido(_, _, _, Equipo, G), G >= 3.

partido_cero_cero(E1, E2) :-
    partido(_, E1, 0, E2, 0).

% ==== Tercera etapa ====
% Solo cuenta goles si el equipo ganó
goles_equipo(E, G) :- partido(_, E, G, _, O), G > O.
goles_equipo(E, G) :- partido(_, _, O, E, G), G > O.

total_goles(E, Total) :-
    findall(G, goles_equipo(E, G), Lista),
    sumlist(Lista, Total).

equipos_mas_de_5_goles(Equipo) :-
    total_goles(Equipo, Total),
    Total > 5.

% ==== Cuarta etapa ====
gano(E) :-
    partido(_, E, G1, _, G2), G1 > G2;
    partido(_, _, G1, E, G2), G2 > G1.

partido_mas_de_5_goles(E1, E2, Total) :-
    partido(_, E1, G1, E2, G2),
    Total is G1 + G2,
    Total > 5.

empato_cero_cero(E) :-
    partido(_, E, 0, _, 0);
    partido(_, _, 0, E, 0).

goleador(E, N) :-
    total_goles(E, N).

% =====================
% PRUEBAS AUTOMÁTICAS
% =====================

pruebas :-
    writeln('--- ¿Ana está conectada con Carla? ---'),
    (conectado(ana, carla) -> writeln('Sí'); writeln('No')), nl,

    writeln('--- Personas ingenieras o médicas ---'),
    forall(ingeniera_o_medica(N), writeln(N)), nl,

    writeln('--- Total de goles (solo partidos ganados) de Costa Rica ---'),
    total_goles(costa_rica, T), writeln(T), nl,

    writeln('--- Equipos con más de 5 goles ---'),
    forall(equipos_mas_de_5_goles(E), writeln(E)), nl,

    writeln('--- Tabla de goleadores (mayor a menor) ---'),
    setof(N-E, goleador(E, N), Lista),
    reverse(Lista, Ordenada),
    writeln(Ordenada).
