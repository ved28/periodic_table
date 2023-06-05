#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
if [[ $1 ]]
then
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    PROPERTIES=$($PSQL "Select * from properties full join elements using(atomic_number) full join types using(type_id) where atomic_number=$1")
  else
    PROPERTIES=$($PSQL "Select * from properties full join elements using(atomic_number) full join types using(type_id) where symbol='$1' or name='$1'")
  fi

  if [[  $PROPERTIES ]]
   then
    echo "$PROPERTIES" | while IFS="|" read TYPE_ID NUMBER MASS MELTING BOILING SYMBOL NAME TYPE
    do
      echo  "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    done
  else
    echo -e "I could not find that element in the database."
  fi
else
  echo -e "Please provide an element as an argument."
fi
