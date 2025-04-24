#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=number_guess --tuples-only -c"

echo Enter your username:
read INPUT_NAME

USER_ID=$($PSQL "SELECT user_id FROM users WHERE name='$INPUT_NAME'")

if [[ -z $USER_ID ]]
then
    echo Welcome, $INPUT_NAME! It looks like this is your first time here.
    # insert new user
    INSERT_USER_RESULT=$($PSQL "INSERT INTO users(name) VALUES('$INPUT_NAME')")
    USER_ID=$($PSQL "SELECT user_id FROM users WHERE name='$INPUT_NAME'")
else
    USER_BEST_GAME=$($PSQL "SELECT MIN(number_guesses) FROM games WHERE user_id=$USER_ID")
    USER_GAMES_PLAYED=$($PSQL "SELECT COUNT(user_id) FROM games WHERE user_id=$USER_ID")
    echo "Welcome back, $INPUT_NAME! You have played $USER_GAMES_PLAYED games, and your best game took $USER_BEST_GAME guesses."
fi

NUMBER=$(( RANDOM % 1000 + 1 ))
COUNTER=0

echo "Guess the secret number between 1 and 1000:"
read INPUT_GUESS

while [[ $INPUT_GUESS -ne $NUMBER ]]
    do 
        #if not a number 
        if [[ ! $INPUT_GUESS =~ ^[0-9]+$ ]]
        then
            echo "That is not an integer, guess again:"
        else
            ((COUNTER++))
            if (( INPUT_GUESS > NUMBER ))
            then
                echo "It's lower than that, guess again:"
            elif (( INPUT_GUESS < NUMBER ))
            then
                echo "It's higher than that, guess again:"
            fi
        fi
        read INPUT_GUESS
    done
((COUNTER++))
echo "You guessed it in $COUNTER tries. The secret number was $NUMBER. Nice job!"
INSERT_USER_TRY=$($PSQL "INSERT INTO games(user_id,number_guesses) VALUES($USER_ID,$COUNTER)")



