@debug
Feature: Sign Up new user

    Background: Preconditions
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * def timeValidator = read('classpath:helpers/timeValidator.js')
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()
        * url apiUrl


    
    Scenario: New user Sign Up
        # Given def userData = {"email": "mehrdadkarate8@test.com","password": "Test123!","username": "MehrdadKarate8"}

        # * def randomEmail = dataGenerator.getRandomEmail()
        # * def randomUsername = dataGenerator.getRandomUsername()
        
        # Used java function with a non static function in the DataGenerator.java
        # * def jsFunction = 
        # """

        #     function () {
        #         var DataGenerator = Java.type('helpers.DataGenerator')
        #         var generator = new DataGenerator()
        #         return generator.getRandomUsername2()
                
        #     }

        # """
        # * def randomUsername2 = call jsFunction

        Given path 'users'
        # And request {"user": {"email": #('Test'+userData.email),"password": "Test123!","username": #('User'+userData.username)}}
        And request
        """               
            {
                "user": {
                    "email": #(randomEmail),
                    "password": "Test123!",
                    "username": #(randomUsername)
                }
            }        
        """
        When method Post
        Then status 200
        And match response ==
        """
            {
                "user": {
                    "email": #(randomEmail),
                    "username": #(randomUsername),
                    "bio": "##string",
                    "image": "#string",
                    "token": "#string"
                }
            }
        """
        
        Scenario Outline: Validate Sign Up error message
            
            # * def randomEmail = dataGenerator.getRandomEmail()
            # * def randomUsername = dataGenerator.getRandomUsername()
            
            
            Given path 'users'
            And request
            """               
                {
                    "user": {
                        "email": "<email>",
                        "password": "<password>",
                        "username": "<username>"
                    }
                }        
            """
            When method Post
            Then status 422
            And match response == <errorResponse>

            Examples:
                | email                     | password      | username                      | errorResponse                                                                      |
                | #(randomEmail)            | Test123!      | mehrdadKarate1                | {"errors":{"username":["has already been taken"]}}                                 |
                | mehrdadKarate1@test.com   | Test123!      | #(randomUsername)             | {"errors":{"email":["has already been taken"]}}                                    |
                # | mehrdadkarate1            | Test123!      | mehrdadKarate1                | {"errors":{"email":["is invalid"]}}                                                |
                # | #(randomEmail)            | Test123!      | mehrdadKarate123123123123     | {"errors":{"username":["is too long (maximum is 20 characters)"]}}                 |
                # | #(randomEmail)            | Tes           | mehrdadKarate1                | {"errors":{"pasword":["is too short (minimum is 8 characters)"]}}                  |
                |                           | Test123!      | mehrdadKarate1                | {"errors":{"email":["can't be blank"]}}                                            |
                | #(randomEmail)            |               | mehrdadKarate1                | {"errors":{"password":["can't be blank"]}}                                         |
                # | #(randomEmail)            | Test123!      |                               | {"errors":{"username":["can't be blank","is too short (minimum is 1 character)"]}} |
