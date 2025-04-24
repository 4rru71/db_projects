CREATE TABLE types(
    type_id INTEGER PRIMARY KEY NOT NULL,
    type VARCHAR(30) NOT NULL
);

INSERT INTO types(type_id,type) 
VALUES (1,'nonmetal'),
(2,'metal'),
(3,'metalloid');

INSERT INTO elements(atomic_number,symbol,name) 
VALUES  (9,'F','Fluorine'),
        (10,'Ne','Neon');

INSERT INTO properties(atomic_number,type,atomic_mass,melting_point_celsius,boiling_point_celsius,type_id) 
VALUES  (9,'nonmetal',18.998,-220,-188.1,1),
        (10,'nonmetal',20.18,-248.6,-246.1,1);
