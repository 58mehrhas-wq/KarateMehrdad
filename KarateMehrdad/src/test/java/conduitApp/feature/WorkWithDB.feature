
Feature: Work with DB

Background: connect to db
    * def dbHandler = Java.type('helpers.DBHandler')

    Scenario: Seed database with a new Job
        * eval dbHandler.addNewJobWithName("Qa5")

    Scenario: Get level for Job
        * def level = dbHandler.getMinAndMaxLevelsForJob("Qa5")
        * print level.minLvl
        * print level.maxLvl
        And match level.minLvl == '50'
        And match level.maxLvl == '120' 
