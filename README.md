# Bunk'em

## Overview

Bunk'em is a online version of the 'Dictionary Game' where an obscure word is selected from the dictionary and players attempt to guess the correct definition, all while creating their own fake definitions to trick the others.

Bunk'em was built in Ruby on Rails, with heavy use of ERB (Embedded Ruby) files to add functionality.

## Playing the Game

Bunk'em opens on a lobby screen where a user can see their games in progress, open games that haven't started, and a menu to create a new game.

Once a game is joined, the program waits until all users have joined. This program was made with the stipulation that we would not use Javascript, so the refreshing of the page is up to the user. 

After all users have joined a word is presented and each user is prompted to create a definition. Then the program will wait until all users have submitted an answer.

The collection of all fake answers, plus one real one, are then shown to the users, who must then select the one they believe to be the true definition.

After all users have selected, score is calculated, with users receiving points for guessing correctly or fooling their friends.

Play continues indefinitely at the discretion of the game owner.

## Authors
David Brennan | david.brennan@flatironschool.com Leslie Hsu | leslie.hsu@flatironschool.com

## License
Copyright 2018

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Acknowledgments
Thank you to our classmates and instructors at the Flatiron School in New York, New York.

Thank you to [The Phrontistery](http://phrontistery.info/) for their awesome collection of obscure words.
