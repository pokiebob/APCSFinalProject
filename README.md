# APCSFinalProject

https://docs.google.com/document/d/1tSAFTTgo5l4CAf2x9fFHQCuG0fYmOD8H5YnAuef8rGo/edit?usp=sharing

## Meandering Towers
- Cyrus Cursetjee
- Hasin Raihan

## Description
A tower defense game based on the “Bloons Tower Defense” series by Ninja Kiwi. The goal is to build and upgrade your towers while the computer sends balloons at you. As each round passes, you receive money based on your interest rate, which you can use to buy newly unlocked towers to defend against increasingly stronger balloons. Each balloon and tower has its own special feature and cost. 

## Development Log

5/25: Group Call after School
- Decided on the screen size and size of patches
- Created basic path.

5/26: Cyrus
- Moved tower menu to the right of the screen. 
- Added ellipse for dartmonkey in menu, with drag and drop functionality.
- Note: Path checker is slightly innacurate, it allows for towers to partially cover the path.
 
5/27: Group Call during free
- Created balloon class with basic speed variable and move and display methods
- Balloons follow the general path, however there is a slight offset due to patches
- Note: new balloon is created each draw loop, causing snake-like trail

5/29: Cyrus
- Starting using ticks to manage balloon spawn rate
- Balloons now take away lives when they reach the end of the path
- Created health bar at the top proportional to number of lives
- Towers can no longer be placed overlapping with each other or the path
- Tower range is displayed using low transparency circle when selected

5/31: Group Call
- Started bullet class, displayed bullet, and got bullet to move across the screen
- Worked on making the bullets disappear when it reaches the tower's range
- Next step is taking the bullet direction into account
- Encountered displaying glitch where the path suddenly became shifted (resolved)
- Encountered a glitch where the first tower made can be placed on the white path if it overlaps with the balloons (unresolved)

6/1: Classwork
- Bullets now face and shoot in the correct direction (angle)
- Towers shoot when they detect balloons
- Note: Timer must be implemented so that there is an interval between each shot
