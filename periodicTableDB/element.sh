#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# if input empty
if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
else
    #if not a number 
    if [[ ! $1 =~ ^[0-9]+$ ]]
    then
        ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1' OR name='$1'")
    else
        ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1")
    fi
    
    # if doesn't exist
    if [[ -z $ATOMIC_NUMBER ]]
    then
        echo I could not find that element in the database.
    else
        RESULT_ELEMENT=$($PSQL "SELECT name,symbol,type,atomic_mass,melting_point_celsius,boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER")

        IFS='|' read NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT <<< "$RESULT_ELEMENT"

        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    
    fi
fi

: '
ALTER TABLE properties
  RENAME COLUMN weight TO atomic_mass,
  RENAME COLUMN melting_point TO melting_point_celsius,
  RENAME COLUMN boiling_point TO boiling_point_celsius,
  ALTER COLUMN melting_point_celsius SET NOT NULL,
  ALTER COLUMN boiling_point_celsius SET NOT NULL;
'
: '
ALTER TABLE elements
  ADD UNIQUE(symbol),
  ADD UNIQUE(name),
  ALTER COLUMN name SET NOT NULL,
  ALTER COLUMN symbol SET NOT NULL;
'
: '
ALTER TABLE properties
  ADD FOREIGN KEY (atomic_number) REFERENCES elements(atomic_number),
  ADD COLUMN type_id INTEGER,
  ADD FOREIGN KEY (type_id) REFERENCES types(type_id),
  ALTER COLUMN type_id SET NOT NULL,
  ALTER COLUMN atomic_mass TYPE REAL;
'