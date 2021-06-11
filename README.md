# APCSFinalProject

https://docs.google.com/document/d/1tSAFTTgo5l4CAf2x9fFHQCuG0fYmOD8H5YnAuef8rGo/edit?usp=sharing

## Meandering Towers
- Cyrus Cursetjee
- Hasin Raihan

## Description
A tower defense game based on the “Bloons Tower Defense” series by Ninja Kiwi. The goal is to build and upgrade your towers while the computer sends balloons at you. As each round passes, you receive money based on your income, which you can use to buy newly unlocked towers to defend against increasingly stronger balloons. Each tower has its own special feature and cost.

## Compile Instructions
- Open the BTD file in Processing
- Download the Sound library by going to Sketch -> Import Library
- Press play!

## How to Play
- On the right hand side of your screen, there will be a menu with three towers: Dart Monkey, Sniper Monkey, and Bomb Tower!
- Click and hold one of the towers to see their stats.
- Place a tower by dragging it next to the balloon path. It will shoot at incoming balloons.
- Each balloon you hit, your income will increase. At the end of each round, your income will be added to your bank.
- Upgrade towers by selecting them and hitting the upgrade button.
- Your goal is to survive 12 rounds... good luck!
- Note: Black balloons are immune to explosions.

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

6/3: Group Call
- Added timer so towers shoot every .45 seconds
- Changed bullet shape to small circle + minor graphics changes
- Towers shoot only one balloon at a time
- Optimized balloon and tower/bullet speed to avoid towers missing balloons
- Reminder: Fix unresolved issue from 5/31

6/4: Group Call
- Implemented a money system in which towers reduce balance when placed
- Balance cannot go below 0
- Currently, balloons popped increase balance, but in the future they will increase income
- Created a basic title screen with a start button using a Button class
- Resolved the tower placement issue from 5/31
- Tower range turns red if it is an illegal placement
- Used a for loop to automate spawning balloons (resembles a real level more)
- Fixed a plethora of array out of bounds exception

6/5: Hasin
- Implemented a timer class (which will be used to show time elapsed/time left in a given round/wave)
- Started working on implementing different balloon types (currently red & blue)

6/6: Group Call
- Programmed 6 rounds of balloon waves
- Created red blue and green balloon types that change color based on current health
- Created Sniper subclass and added it to menu
- Switched to income based profit based on damage dealt to balloons
- Balanced dart and sniper tower speeds as well as balloon speeds

6/7: Group Call
- User can now click on towers to select them
- Selected Towers display stats on bottom right corner
- Tower images shown in displayed stats
- Stopped using hand cursor
- Modified sniper bullet velocity and increased balloon hit box to compensate for sniper missing balloons on occasion

6/8: Cyrus
- Created BombTower and Bomb classes and added it to menu
- Bombs deal splash damage to surrounding balloons
- Tower stats displayed when dragging tower
- Display tower stats modified to include level

6/9: Group Call
- Added some ballon types and balanced game
- Created upgrade button that upgrades to 4 levels for each tower
- Fixed path error due to high speed balloons
- Edited display tower stats
- To Do: Start and end screens, upgrade cost, complete 20 rounds

6/10: Group Call
- Created 12 rounds  with increasing difficulty.
- Added pop sound effects and background music
- Created btd start screen and make buttons look good
- Fixed triple shot upgrade for dart monkey
- Upgrade buttons get deactivated at tower level 4
- Balanced tower upgrade costs
- Balanced Final rounds
- Created Victory and Defeat screens with restart buttons
