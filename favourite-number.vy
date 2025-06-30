# DONE  Create a function called add that adds 1 to whatever is in self.favorite_number
# DONE Have the starting favorite number different from 7, check to make sure it's the number you set!
# DONE Create a new type using the "struct" keyword, and create a function that will save a new variable of that type to a state/storage variable.

# pragma version 0.4.0
# @license MIT

struct Person:
    favourite_number: uint256
    name: String[100]

struct Favourites:
    favourite_icecream: String[100]
    favourite_band: String[100]

my_name: public(String[100])
my_favourite_number:public(uint256)
my_favourites:public(Favourites)

list_of_numbers: public(uint256[5])
list_of_people: public(Person[5])
index: public(uint256)

name_to_favourite_number: public(HashMap[String[100], uint256])

@deploy
def __init__():
    self.my_favourite_number = 3
    self.index = 0

@external
def store (new_number: uint256):
    self.my_favourite_number = new_number

@external
def add() -> uint256:
    self.my_favourite_number += 1


@external
def set_favourite_things(favourite_icecream: String[100], favourite_band:String[100]):
    new_favourites: Favourites = Favourites(
        favourite_icecream = favourite_icecream,
        favourite_band = favourite_band
    )
    self.my_favourites = new_favourites

@external
@view # no reason to update state here, override vyper defaults
def retrieve() -> uint256:
    return self.my_favourite_number

@external
def add_person(name: String[100], favourite_number: uint256):
    # Add the number to the numbers list
    self.list_of_numbers[self.index] = favourite_number

    # Add the person to the persons list
    new_person: Person = Person(favourite_number = favourite_number, name = name)
    self.list_of_people[self.index] = new_person

    #Add the person to the hashmap
    self.name_to_favourite_number[name] = favourite_number

    self.index = self.index + 1
