#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"

MAIN_MENU() {
    if [[ $1 ]]
    then
        echo -e "\n$1"
    else
        echo -e "Welcome to My Salon, how can I help you?\n" 
    fi

    # get available services
    AVAILABLE_SERVICES=$($PSQL "SELECT service_id,name FROM services ORDER BY service_id")
    
    # display available services
    echo "$AVAILABLE_SERVICES" | while read SERVICE_ID BAR NAME 
    do
        echo "$SERVICE_ID) $NAME"
    done
    read SERVICE_ID_SELECTED

    # get service name
    SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")

    # if not available
    if [[ -z $SERVICE_NAME ]]
    then
        # send to main menu
        MAIN_MENU "I could not find that service. What would you like today?"
    else
        # get customer info
        echo -e "\nWhat's your phone number?"
        read CUSTOMER_PHONE
        CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")

        # if customer doesn't exist
        if [[ -z $CUSTOMER_NAME ]]
        then
            #get new customer name
            echo -e "\nI don't have a record for that phone number, what's your name?"
            read CUSTOMER_NAME

            # insert new customer
            INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
        fi

        #get customer id
        CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

        #get customer time
        
        echo -e "\nWhat time would you like your $(echo $SERVICE_NAME | sed -r 's/^ *| *$//g'), $CUSTOMER_NAME?"
        read SERVICE_TIME

        #insert appointment
        INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")

        echo -e "\nI have put you down for a $SERVICE_NAME at $(echo $SERVICE_NAME | sed -r 's/^ *| *$//g'), $CUSTOMER_NAME."
    fi
}


MAIN_MENU