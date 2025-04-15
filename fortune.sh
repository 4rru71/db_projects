#!/bin/bash

# Program to tell a persons fortune

echo -e "\n~~ Fortune Teller ~~\n"

#echo ${ARR[*]} imprime todos los elementos del array
# =~ comprueba la coincidencia de un patron 
# ^<letter> comprueba si inicia con 
# \?$ check if your variable ends with ?

RESPONSES=("Yes" "No" "Maybe" "Outlook good" "Don't count on it" "Ask again later")

#echo ${RESPONSES[5]} 6to elemento del arreglo

N=$(( RANDOM % 6 ))
#echo ${RESPONSES[$N]}  Elemento aleatorio del arreglo

function GET_FORTUNE() {
    if [[ ! $1 ]]
        then
            echo Ask a yes or no question:
        else
            echo Try again. Make sure it ends with a question mark:
    fi
  read QUESTION
}
GET_FORTUNE

until [[ $QUESTION =~ \?$ ]]
    do
    GET_FORTUNE again
    done

echo -e "\n${RESPONSES[$N]}"