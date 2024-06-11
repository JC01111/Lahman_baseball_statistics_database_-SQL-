# Lahman's baseball statistics database

This is the file I use to demonstrate my abilitiy of sqlite, if you want to look at the tasks of SQL queries, jump to `tasks`. Otherwise, you can follow the document to set up your environment and debug anything you have about testing or other issues.

## Required Software

### SQLite3

Check if you already have sqlite3 instead by opening a terminal and running `sqlite3 --version`. Any version at 3.8.3 or higher should be fine.

If you don't already have SQLite on your machine, the simplest way to start using it is to download a precompiled binary from the [SQLite website](http://www.sqlite.org/download.html).

#### Windows <a id="windows"></a>

1. Visit the download page linked above and navigate to the section **Precompiled Binaries for Windows**. Click on the link **sqlite-tools-win32-x86-\*.zip** to download the binary.
2. Unzip the file. There should be a `sqlite3.exe` file in the directory after extraction.
3. Navigate to the folder containing the `sqlite3.exe` file and check that the version is at least 3.8.3: `cd path/to/sqlite_folder` `./sqlite3 --version`
4. Move the `sqlite3.exe` executable into this directory \(the same place as the `queries.sql` file\)

#### macOS Yosemite \(10.10\), El Capitan \(10.11\), Sierra \(10.12\) <a id="macos-yosemite-10-10-el-capitan-10-11-sierra-10-12"></a>

SQLite comes pre-installed. Check that you have a version that's greater than 3.8.3 `sqlite3 --version`

#### Mac OS X Mavericks \(10.9\) or older <a id="mac-os-x-mavericks-10-9-or-older"></a>

SQLite comes pre-installed, but it is the wrong version.

1. Visit the download page linked above and navigate to the section **Precompiled Binaries for Mac OS X \(x86\)**. Click on the link **sqlite-tools-osx-x86-\*.zip** to download the binary.
2. Unzip the file. There should be a `sqlite3` file in the directory after extraction.
3. Navigate to the folder containing the `sqlite3` file and check that the version is at least 3.8.3: `cd path/to/sqlite_folder` `./sqlite3 --version`
4. Move the `sqlite3` file into this directory \(the same place as the `queries.sql` file\)

#### Ubuntu

Install with `sudo apt install sqlite3`

For other Linux distributions you'll need to find `sqlite3` on your appropriate package manager. Alternatively you can follow the Mac OS X \(10.9\) or older instructions substituting the Mac OS X binary for one from **Precompiled Binaries for Linux.**

### Python

You'll need a copy of Python 3.5 or higher to run the tests for this project locally. You can check if you already have an existing copy by running `python3 --version` in a terminal. If you don't already have a working copy download and install one for your appropriate platform from [here](https://www.python.org/downloads/).

## Running the tests

If you followed the instructions above you should now be able to test your code. Navigate to your project directory and try using `python3 test.py`. You should get output similar to the following:

```text
FAIL q0 see diffs/q0.txt
FAIL q1i see diffs/q1i.txt
FAIL q1ii see diffs/q1ii.txt
FAIL q1iii see diffs/q1iii.txt
FAIL q1iv see diffs/q1iv.txt
FAIL q2i see diffs/q2i.txt
FAIL q2ii see diffs/q2ii.txt
FAIL q2iii see diffs/q2iii.txt
FAIL q3i see diffs/q3i.txt
FAIL q3ii see diffs/q3ii.txt
FAIL q3iii see diffs/q3iii.txt
FAIL q4i see diffs/q4i.txt
FAIL q4ii_bins_0_to_8 see diffs/q4ii_bins_0_to_8.txt
FAIL q4ii_bin_9 see diffs/q4ii_bin_9.txt
FAIL q4iii see diffs/q4iii.txt
FAIL q4iv see diffs/q4iv.txt
FAIL q4v see diffs/q4v.txt
```

If so, move on to the next section to start the project. If you see `ERROR`instead of `FAIL` create a followup on Edstem with details from your `your_output/` folder.

## Testing

You can run your answers through SQLite directly by running `sqlite3 lahman.db` to open the database and then entering `.read proj1.sql`

```text
$ sqlite3 lahman.db
SQLite version 3.33.0 2020-08-14 13:23:32
Enter ".help" for usage hints.
sqlite> .read proj1.sql
```

This can help you catch any syntax errors in your SQLite.

To help debug your logic, we've provided output from each of the views you need to define in questions 1-4 for the data set you've been given. Your views should match ours, but note that your SQL queries should work on ANY data set. **We will test your queries on a \(set of\) different database\(s\), so it is** _**NOT**_ **sufficient to simply return these results in all cases!** Please also note that queries that join on extra, unnecessary tables will slow down queries and not receive full credit on the hidden tests.

To run the test, from within the `Lahman_baseball_statistics_database_SQL` directory:

```text
$ python3 test.py
$ python3 test.py -q 4ii # This would run tests for only q4ii
```

Become familiar with the UNIX [diff](http://en.wikipedia.org/wiki/Diff) format, if you're not already, because our tests saves a simplified diff for any query executions that don't match in `diffs/`. As an example, the following output for `diffs/q1i.txt:`:

```text
- 1|1|1
+ Jumbo|Diaz|1984
+ Walter|Young|1980
```

indicates that your output has an extra `1|1|1` \(the `-` at the beginning means the expected output _doesn't_ include this line but your output has it\) and is missing the lines `Jumbo|Diaz|1984` and `Walter|Young|1980` \(the plus at the beginning means the expected output _does_ include those lines but your output is missing it\). If there is neither a `+` nor `-` at the beginning then it means that the line is in both your output and the expected output \(your output is correct for that line\).

If you care to look at the query outputs directly, ours are located in the `expected_output` directory. Your view output should be located in your solution's `your_output` directory once you run the tests.

**Note:** For queries where we don't specify the order, it doesn't matter how you sort your results; we will reorder before comparing. Note, however, that our test query output is sorted for these cases, so if you're trying to compare yours and ours manually line-by-line, make sure you use the proper ORDER BY clause \(you can determine this by looking in `test.py`\). Different versions of SQLite handle floating points slightly differently so we also round certain floating point values in our own queries. A full list is specified here for convenience:

```sql
SELECT * FROM q0;
SELECT * FROM q1i ORDER BY namefirst, namelast, birthyear;
SELECT * FROM q1ii ORDER BY namefirst, namelast, birthyear;
SELECT birthyear, ROUND(avgheight, 4), count FROM q1iii;
SELECT birthyear, ROUND(avgheight, 4), count FROM q1iv;
SELECT * FROM q2i;
SELECT * FROM q2ii;
SELECT * FROM q2iii;
SELECT playerid, namefirst, namelast, yearid, ROUND(slg, 4) FROM q3i;
SELECT playerid, namefirst, namelast, ROUND(lslg, 4) FROM q3ii;
SELECT namefirst, namelast, ROUND(lslg, 4) FROM q3iii ORDER BY namefirst, namelast;
SELECT yearid, min, max, ROUND(avg, 4) FROM q4i;
SELECT * FROM q4ii WHERE binid <> 9;
WITH max_salary AS (SELECT MAX(salary) AS salary FROM salaries)
        SELECT binid, low,
            ((CASE WHEN high >= salary THEN '' ELSE 'not ' END) ||
                    'at least ' || salary) AS high, count
        FROM q4ii, max_salary WHERE binid = 9;
SELECT yearid, mindiff, maxdiff, ROUND(avgdiff, 4) FROM q4iii;
SELECT * FROM q4iv ORDER BY yearid, playerid;
SELECT team, ROUND(diffAvg, 4) FROM q4v ORDER BY team;
```

<br>

## Before we begin

In this project we will be working with the commonly-used [Lahman baseball statistics database](http://www.seanlahman.com/baseball-archive/statistics/) (our friends at the San Francisco Giants tell us they use it!) The database contains pitching, hitting, and fielding statistics for Major League Baseball from 1871 through 2019. It includes data from the two current leagues (American and National), four other "major" leagues (American Association, Union Association, Players League, and Federal League), and the National Association of 1871-1875.

At this point you should be able to run SQLite and view the database using either `./sqlite3 -header lahman.db` (if in the previous section you downloaded a precompiled binary) or `sqlite3 -header lahman.db` otherwise. If you're using windows and you find that the previous command doesn't work, try running `winpty ./sqlite3 lahman.db`.

```
$ sqlite3 lahman.db
SQLite version 3.33.0 2020-08-14 13:23:32
Enter ".help" for usage hints.
sqlite> .tables
```

Try running a few sample commands in the SQLite console and see what they do:

```
sqlite> .schema people
```

```
sqlite>  SELECT playerid, namefirst, namelast FROM people;
```

```
sqlite> SELECT COUNT(*) FROM fielding;
```

## Understanding the Schema

The database is comprised of the following main tables:

```
People - Player names, date of birth (DOB), and biographical info
Batting - batting statistics
Pitching - pitching statistics
Fielding - fielding statistics
```

It is supplemented by these tables:

```
  AllStarFull - All-Star appearances
  HallofFame - Hall of Fame voting data
  Managers - managerial statistics
  Teams - yearly stats and standings
  BattingPost - post-season batting statistics
  PitchingPost - post-season pitching statistics
  TeamFranchises - franchise information
  FieldingOF - outfield position data
  FieldingPost- post-season fielding data
  FieldingOFsplit - LF/CF/RF splits
  ManagersHalf - split season data for managers
  TeamsHalf - split season data for teams
  Salaries - player salary data
  SeriesPost - post-season series information
  AwardsManagers - awards won by managers
  AwardsPlayers - awards won by players
  AwardsShareManagers - award voting for manager awards
  AwardsSharePlayers - award voting for player awards
  Appearances - details on the positions a player appeared at
  Schools - list of colleges that players attended
  CollegePlaying - list of players and the colleges they attended
  Parks - list of major league ballparks
  HomeGames - Number of homegames played by each team in each ballpark
```

For more detailed information, see the [docs online](http://www.seanlahman.com/files/database/readme2019.txt).

## Writing Queries

There is a skeleton solution file, `queries.sql`, to help you get started. In the file, you'll find a `CREATE VIEW` statement for each part of the first 4 questions below, specifying a particular view name (like `q2i`) and list of column names (like `playerid`, `lastname`). The view name and column names constitute the interface against which we will grade this assignment. In other words, _don't change or remove these names_. Your job is to fill out the view definitions in a way that populates the views with the right tuples.

For example, consider Question 0: "What is the highest `era` ([earned run average](https://en.wikipedia.org/wiki/Earned\_run\_average)) recorded in baseball history?".

In the `queries.sql` file we provide:

```sql
CREATE VIEW q0(era) AS
    SELECT 1 -- replace this line
;
```

You would edit this with your answer, keeping the schema the same:

```sql
-- solution you provide
CREATE VIEW q0(era) AS
 SELECT MAX(era)
 FROM pitching
;
```

To complete the project, create a view for `q0` as above (via copy-paste), and for all of the following queries, which you will need to write yourself.

You can confirm the test is now passing by running `python3 test.py -q 0`

```
> python3 test.py -q 0
PASS q0
```

## Tasks

### Task 1: **Basics**

**i.** In the `people` table, find the `namefirst`, `namelast` and `birthyear` for all players with weight greater than 300 pounds.

**Ans:**
```sql
CREATE VIEW q1i(namefirst, namelast, birthyear)
AS
  SELECT namefirst, namelast, birthyear FROM people WHERE weight > 300
;
```

**Output:**
```
namefirst|namelast|birthyear
Jumbo|Diaz|1984
Walter|Young|1980
```

<br>

**ii.** Find the `namefirst`, `namelast` and `birthyear` of all players whose `namefirst` field contains a space. Order the results by `namefirst`, breaking ties with `namelast` both in ascending order

**Ans:**
```sql
CREATE VIEW q1ii(namefirst, namelast, birthyear)
AS
  SELECT namefirst, namelast, birthyear FROM people WHERE namefirst LIKE '% %'
  ORDER BY namefirst, namelast
;
```

**Output:**
```
namefirst|namelast|birthyear
A. J.|Achter|1988
A. J.|Burnett|1977
A. J.|Cole|1992
A. J.|Ellis|1981
A. J.|Griffin|1988
A. J.|Hinch|1974
A. J.|Jimenez|1990
A. J.|Minter|1993
......
```

<br>

**iii.** From the `people` table, group together players with the same `birthyear`, and report the `birthyear`, average `height`, and number of players for each `birthyear`. Order the results by `birthyear` in _ascending_ order.

Note: Some birth years have no players; your answer can simply skip those years. In some other years, you may find that all the players have a `NULL` height value in the dataset (i.e. `height IS NULL`); your query should return `NULL` for the height in those years.

**Ans:**
```sql
CREATE VIEW q1iii(birthyear, avgheight, count)
AS
  SELECT birthyear, AVG(height), COUNT(*) FROM people GROUP BY birthyear
  ORDER BY birthyear
;
```

**Output:**
```
birthyear|ROUND(avgheight, 4)|count
|69.3571|115
1820||1
1824||1
1832||3
1835|69.0|1
1836|63.0|1
1837||1
1838|69.0|3
1839|72.0|1
1840|68.5|7
1841|68.3333|3
1842|68.4|6
1843|67.5|8
......
```

<br>

**iv.** Following the results of part iii, now only include groups with an average height > `70`. Again order the results by `birthyear` in _ascending_ order.

**Ans:**
```sql
CREATE VIEW q1iv(birthyear, avgheight, count)
AS
  SELECT birthyear, AVG(height), COUNT(*) FROM people
  GROUP BY birthyear HAVING AVG(height) > 70 ORDER BY birthyear
;
```

**Output:**
```
birthyear|ROUND(avgheight, 4)|count
1839|72.0|1
1868|70.1143|90
1871|70.283|64
1872|70.1695|70
1873|70.2469|86
1874|70.1512|100
1876|70.0515|111
1877|70.6216|88
1878|70.3452|91
......
```

<br>

### Task 2: **Hall of Fame Schools**

**i.** Find the `namefirst`, `namelast`, `playerid` and `yearid` of all people who were successfully inducted into the Hall of Fame in _descending_ order of `yearid`. Break ties on `yearid` by `playerid` (ascending).

**Ans:**
```sql
CREATE VIEW q2i(namefirst, namelast, playerid, yearid)
AS
  SELECT p.namefirst, p.namelast, h.playerid, h.yearid
  FROM people AS p INNER JOIN halloffame AS h ON p.playerid = h.playerid
  WHERE h.inducted = 'Y'
  ORDER BY h.yearid DESC, h.playerid
;
```

**Output:**
```
namefirst|namelast|playerid|yearid
Vladimir|Guerrero|guerrvl01|2018
Trevor|Hoffman|hoffmtr01|2018
Chipper|Jones|jonesch06|2018
Jack|Morris|morrija02|2018
Jim|Thome|thomeji01|2018
Alan|Trammell|trammal01|2018
Jeff|Bagwell|bagweje01|2017
Tim|Raines|raineti01|2017
Ivan|Rodriguez|rodriiv01|2017
John|Schuerholz|schurjo99|2017
Bud|Selig|seligbu99|2017
......
```

<br>

**ii.** Find the people who were successfully inducted into the Hall of Fame and played in college at a school located in the state of California. For each person, return their `namefirst`, `namelast`, `playerid`, `schoolid`, and `yearid` in _descending_ order of `yearid`. Break ties on `yearid` by `schoolid, playerid` (ascending). For this question, `yearid` refers to the year of induction into the Hall of Fame.

* Note: a player may appear in the results multiple times (once per year in a college in California).

**Ans:**
```sql
CREATE VIEW q2ii(namefirst, namelast, playerid, schoolid, yearid)
AS
  SELECT p.namefirst, p.namelast, h.playerid, s.schoolid, h.yearid FROM people AS p
  INNER JOIN halloffame AS h ON p.playerid = h.playerid INNER JOIN collegeplaying
      AS c ON p.playerid = c.playerid INNER JOIN schools AS s ON c.schoolid = s.schoolid
  WHERE h.inducted = 'Y' AND s.schoolstate = 'CA'
  ORDER BY h.yearid DESC, s.schoolid, h.playerid
;
```

**Output:**
```
namefirst|namelast|playerid|schoolid|yearid
Trevor|Hoffman|hoffmtr01|cacypre|2018
Trevor|Hoffman|hoffmtr01|cacypre|2018
Randy|Johnson|johnsra05|usc|2015
Randy|Johnson|johnsra05|usc|2015
Randy|Johnson|johnsra05|usc|2015
Pat|Gillick|gillipa99|calavco|2011
Pat|Gillick|gillipa99|usc|2011
Pat|Gillick|gillipa99|usc|2011
......
```

<br>

**iii.** Find the `playerid`, `namefirst`, `namelast` and `schoolid` of all people who were successfully inducted into the Hall of Fame -- whether or not they played in college. Return people in _descending_ order of `playerid`. Break ties on `playerid` by `schoolid` (ascending). (Note: `schoolid` should be `NULL` if they did not play in college.)

**Ans:**
```sql
CREATE VIEW q2iii(playerid, namefirst, namelast, schoolid)
AS
  SELECT p.playerid, p.namefirst, p.namelast, c.schoolid FROM people AS p
  INNER JOIN halloffame AS h ON p.playerid = h.playerid LEFT JOIN collegeplaying
      AS c ON p.playerid = c.playerid
  WHERE h.inducted = 'Y' ORDER BY h.playerid DESC, c.schoolid
;
```

**Output:**
```
playerid|namefirst|namelast|schoolid
yountro01|Robin|Yount|
youngro01|Ross|Youngs|
youngcy01|Cy|Young|
yawketo99|Tom|Yawkey|
yastrca01|Carl|Yastrzemski|
wynnea01|Early|Wynn|
wrighha01|Harry|Wright|
wrighge01|George|Wright|
winfida01|Dave|Winfield|minnesota
winfida01|Dave|Winfield|minnesota
winfida01|Dave|Winfield|minnesota
wilsoju99|Jud|Wilson|
......
```

<br>

### Task 3: [**SaberMetrics**](https://en.wikipedia.org/wiki/Sabermetrics)

**i.** Find the `playerid`, `namefirst`, `namelast`, `yearid` and single-year `slg` (Slugging Percentage) of the players with the 10 best annual Slugging Percentage recorded over all time. A player can appear multiple times in the output. For example, if Babe Ruth’s `slg` in 2000 and 2001 both landed in the top 10 best annual Slugging Percentage of all time, then we should include Babe Ruth twice in the output. For statistical significance, only include players with more than 50 at-bats in the season. Order the results by `slg` descending, and break ties by `yearid, playerid` (ascending).

* Baseball note: Slugging Percentage is not provided in the database; it is computed according to a [simple formula](https://en.wikipedia.org/wiki/Slugging\_percentage) you can calculate from the data in the database.
* SQL note: You should compute `slg` properly as a floating point number---you'll need to figure out how to convince SQL to do this!
* Data set note: The online documentation `batting` mentions two columns `2B` and `3B`. On your local copy of the data set these have been renamed `H2B` and `H3B` respectively (columns starting with numbers are tedious to write queries on).
* Data set note: The column `H` o f the `batting` table represents all hits = (# singles) + (# doubles) + (# triples) + (# home runs), not just (# singles) so you’ll need to account for some double-counting
* If a player played on multiple teams during the same season (for example `anderma02` in 2006) treat their time on each team separately for this calculation

**Ans:**
```sql
CREATE VIEW q3i(playerid, namefirst, namelast, yearid, slg)
AS
  SELECT p.playerid, p.namefirst, p.namelast, b.yearid,
    CAST(SUM(b.H-b.H2B-b.H3B-b.HR)+2*SUM(b.H2B)+3*SUM(b.H3B)+4*SUM(b.HR) AS FLOAT)
      / CAST(SUM(b.AB) AS FLOAT) AS slg
  FROM people AS p INNER JOIN batting AS b ON p.playerid = b.playerid
  WHERE b.AB > 50 GROUP BY p.playerid, p.namefirst, p.namelast, b.yearid, b.teamid
  ORDER BY slg DESC, b.yearid, b.playerid LIMIT 10
;
```

**Output:**
```
playerid|namefirst|namelast|yearid|ROUND(slg, 4)
spencsh01|Shane|Spencer|1998|0.9104
willite01|Ted|Williams|1953|0.9011
bondsba01|Barry|Bonds|2001|0.8634
ruthba01|Babe|Ruth|1920|0.849
ruthba01|Babe|Ruth|1921|0.8463
bakerje03|Jeff|Baker|2006|0.8246
anderma02|Marlon|Anderson|2006|0.8125
bondsba01|Barry|Bonds|2004|0.8123
bondsba01|Barry|Bonds|2002|0.799
ruthba01|Babe|Ruth|1927|0.7722
......
```

<br>

**ii.** Following the results from Part i, find the `playerid`, `namefirst`, `namelast` and `lslg` (Lifetime Slugging Percentage) for the players with the top 10 Lifetime Slugging Percentage. Lifetime Slugging Percentage (LSLG) uses the same formula as Slugging Percentage (SLG), but it uses the number of singles, doubles, triples, home runs, and at bats each player has over their entire career, rather than just over a single season.

Note that the database only gives batting information broken down by year; you will need to convert to total information across all time (from the earliest date recorded up to the last date recorded) to compute `lslg`. Order the results by `lslg` (descending) and break ties by `playerid` (ascending)

* Note: Make sure that you only include players with more than 50 at-bats across their lifetime.

**Ans:**
```sql
CREATE VIEW q3ii(playerid, namefirst, namelast, lslg)
AS
  SELECT p.playerid, p.namefirst, p.namelast,
    CAST(SUM(b.H-b.H2B-b.H3B-B.HR)+2*SUM(b.H2B)+3*SUM(b.H3B)+4*SUM(b.HR) AS FLOAT)
      / CAST(SUM(b.AB) AS FLOAT) AS lslg
  FROM people AS p INNER JOIN batting AS b ON p.playerid = b.playerid
  GROUP BY p.playerid HAVING SUM(b.AB) > 50 ORDER BY lslg DESC, p.playerid
  LIMIT 10
;
```

**Output:**
```
playerid|namefirst|namelast|ROUND(lslg, 4)
ruthba01|Babe|Ruth|0.6898
alvaryo01|Yordan|Alvarez|0.655
hillisa01|Sam|Hilliard|0.6494
willite01|Ted|Williams|0.6338
gehrilo01|Lou|Gehrig|0.6324
foxxji01|Jimmie|Foxx|0.6093
bondsba01|Barry|Bonds|0.6069
greenha01|Hank|Greenberg|0.605
bassjo01|John|Bass|0.6
lewisky01|Kyle|Lewis|0.5915
......
```

<br>

**iii.** Find the `namefirst`, `namelast` and Lifetime Slugging Percentage (`lslg`) of batters whose lifetime slugging percentage is higher than that of San Francisco favorite Willie Mays.

You may include Willie Mays' `playerid` in your query (`mayswi01`), but you _may not_ include his slugging percentage -- you should calculate that as part of the query. (Test your query by replacing `mayswi01` with the playerid of another player -- it should work for that player as well! We may do the same in the autograder.)

* Note: Make sure that you still only include players with more than 50 at-bats across their lifetime.

_Just for fun_: For those of you who are baseball buffs, variants of the above queries can be used to find other more detailed SaberMetrics, like [Runs Created](https://en.wikipedia.org/wiki/Runs\_created) or [Value Over Replacement Player](https://en.wikipedia.org/wiki/Value\_over\_replacement\_player). Wikipedia has a nice page on [baseball statistics](https://en.wikipedia.org/wiki/Baseball\_statistics); most of these can be computed fairly directly in SQL.

_Also just for fun_: SF Giants VP of Baseball Operations, [Yeshayah Goldfarb](https://www.mlb.com/giants/team/front-office/yeshayah-goldfarb), suggested the following:

> Using the Lahman database as your guide, make an argument for when MLBs “Steroid Era” started and ended. There are a number of different ways to explore this question using the data.

(Please do not include your "just for fun" answers in your solution file! They will break the autograder.)

**Ans:**
```sql
CREATE VIEW q3iii(namefirst, namelast, lslg)
AS
  SELECT p.namefirst, p.namelast,
    CAST(SUM(b.H-b.H2B-b.H3B-B.HR)+2*SUM(b.H2B)+3*SUM(b.H3B)+4*SUM(b.HR) AS FLOAT)
      / CAST(SUM(b.AB) AS FLOAT) AS lslg
  FROM people AS p INNER JOIN batting AS b ON p.playerid = b.playerid
  GROUP BY p.playerid HAVING SUM(b.AB) > 50 AND
    lslg > (SELECT CAST(SUM(b2.H-b2.H2B-b2.H3B-b2.HR)+2*SUM(b2.H2B)+3*SUM(b2.H3B)+4*SUM(b2.HR) AS FLOAT)
      / CAST(SUM(b2.AB) AS FLOAT) AS slg FROM people AS p2 INNER JOIN batting AS b2
        ON p2.playerid = b2.playerid WHERE p2.playerid = 'mayswi01')
;
```

**Output:**
```
namefirst|namelast|ROUND(lslg, 4)
Aaron|Judge|0.5582
Albert|Belle|0.5638
Aristides|Aquino|0.5728
Babe|Ruth|0.6898
Barry|Bonds|0.6069
Bo|Bichette|0.5714
Cody|Bellinger|0.5592
D. T.|Cromer|0.5769
Fernando|Tatis|0.5898
......
```

<br>

### Task 4: **Salaries**

**i.** Find the `yearid`, min, max and average of all player salaries for each year recorded, ordered by `yearid` in _ascending_ order.

**Ans:**
```sql
CREATE VIEW q4i(yearid, min, max, avg)
AS
  SELECT yearid, MIN(salary), MAX(salary), AVG(salary) FROM salaries GROUP BY yearid
  ORDER BY yearid
;
```

**Output:**
```
yearid|min|max|ROUND(avg, 4)
1985|60000.0|2130300.0|476299.4473
1986|60000.0|2800000.0|417147.0434
1987|62500.0|2127333.0|434729.4657
1988|62500.0|2340000.0|453171.0769
1989|62500.0|2766667.0|506323.0816
1990|100000.0|3200000.0|511973.6943
1991|100000.0|3800000.0|894961.1942
1992|109000.0|6100000.0|1047520.5761
1993|0.0|6200000.0|976966.559
1994|50000.0|6300000.0|1049588.56
......
```

<br>

**ii.** For salaries in 2016, compute a [histogram](https://en.wikipedia.org/wiki/Histogram). Divide the salary range into 10 equal bins from min to max, with `binid`s 0 through 9, and count the salaries in each bin. Return the `binid`, `low` and `high` boundaries for each bin, as well as the number of salaries in each bin, with results sorted from smallest bin to largest.

* Note: `binid` 0 corresponds to the lowest salaries, and `binid` 9 corresponds to the highest. The ranges are left-inclusive (i.e. `[low, high)`) -- so the `high` value is excluded. For example, if bin 2 has a `high` value of 100000, salaries of 100000 belong in bin 3, and bin 3 should have a `low` value of 100000.
* Note: The `high` value for bin 9 may be inclusive).
* Note: The test for this question is broken into two parts. Use `python3 test.py -q 4ii_bins_0_to_8` and `python3 test.py -q 4ii_bin_9` to run the tests
* Hidden testing advice: we will be testing the case where a bin has zero player salaries in it. The correct behavior in this case is to display the correct `binid`, `low` and `high` with a `count` of zero, NOT just excluding the bin altogether.

Some useful information:

* In the lahman.db, you may find it helpful to use the provided helper table `binids`, which contains all the possible `binid`s. Get a feel of what the data looks like by running `SELECT * FROM binids;` in a sqlite terminal. We'll only be testing with these possible binids (there aren't any hidden tests using say, 100 bins) so using the hardcoded table is fine
* If you want to take the [floor ](https://en.wikipedia.org/wiki/Floor\_and\_ceiling\_functions)of a positive float value you can do `CAST (some_value AS INT)`

**Ans:**
```sql
CREATE VIEW q4ii(binid, low, high, count)
AS
  WITH R(min_salary, max_salary, bin_size) AS (
      SELECT MIN(salary), MAX(salary), (MAX(salary) - MIN(salary)) / 10.0 FROM salaries
      WHERE yearid = 2016
  ),
  bins AS (
      SELECT binid, R.min_salary + (binid * R.bin_size) AS low,
          R.min_salary + ((binid + 1) * R.bin_size) AS high,
          R.max_salary AS last_bin_high
      FROM binids, R
  )
  SELECT b.binid, b.low, (b.binid = 9) * b.last_bin_high + (b.binid < 9) * b.high,
      ( SELECT COUNT(*)
          FROM salaries WHERE yearid = 2016 AND salary >= b.low
          AND (
              (b.binid < 9 AND salary < b.high) OR
              (b.binid = 9 AND salary <= b.last_bin_high)
          )
      ) AS count
  FROM bins AS b ORDER BY b.binid
;
```

**Output:**
```
binid|low|high|count
0|507500.0|3756750.0|558
1|3756750.0|7006000.0|114
2|7006000.0|10255250.0|60
3|10255250.0|13504500.0|44
4|13504500.0|16753750.0|24
5|16753750.0|20003000.0|19
6|20003000.0|23252250.0|21
7|23252250.0|26501500.0|7
8|26501500.0|29750750.0|3

binid|low|high|count
9|29750750.0|at least 33000000.0|3
```

<br>

**iii.** Now let's compute the Year-over-Year change in min, max and average player salary. For each year with recorded salaries after the first, return the `yearid`, `mindiff`, `maxdiff`, and `avgdiff` with respect to the previous year. Order the output by `yearid` in _ascending_ order. (You should omit the very first year of recorded salaries from the result.)

**Ans:**
```sql
CREATE VIEW q4iii(yearid, mindiff, maxdiff, avgdiff)
AS
  WITH stat(yearid, min_salary, max_salary, avg_salary) AS (
    SELECT yearid, MIN(salary), MAX(salary), AVG(salary) FROM salaries GROUP BY yearid
  )
  SELECT s1.yearid, s1.min_salary - s0.min_salary, s1.max_salary - s0.max_salary,
    s1.avg_salary - s0.avg_salary
  FROM stat AS s0 INNER JOIN stat AS s1 ON s1.yearid = s0.yearid+1 ORDER BY s1.yearid
;
```

**Output:**
```
yearid|mindiff|maxdiff|ROUND(avgdiff, 4)
1986|0.0|669700.0|-59152.4039
1987|2500.0|-672667.0|17582.4223
1988|0.0|212667.0|18441.6112
1989|0.0|426667.0|53152.0047
1990|37500.0|433333.0|5650.6128
1991|0.0|600000.0|382987.4998
1992|9000.0|2300000.0|152559.3819
1993|-109000.0|100000.0|-70554.017
......
```

<br>

**iv.** In 2001, the max salary went up by over $6 million. Write a query to find the players that had the max salary in 2000 and 2001. Return the `playerid`, `namefirst`, `namelast`, `salary` and `yearid` for those two years. If multiple players tied for the max salary in a year, return all of them.

* Note on notation: you are computing a relational variant of the [argmax](https://en.wikipedia.org/wiki/Arg\_max) for each of those two years.

**Ans:**
```sql
CREATE VIEW q4iv(playerid, namefirst, namelast, salary, yearid)
AS
  SELECT p.playerid, p.namefirst, p.namelast, s.salary, s.yearid FROM people AS p
  INNER JOIN salaries AS s ON p.playerid = s.playerid
  WHERE (s.yearid = 2000 AND s.salary = (SELECT MAX(salary) FROM salaries WHERE yearid = 2000))
    OR (s.yearid = 2001 AND s.salary = (SELECT MAX(salary) FROM salaries WHERE yearid = 2001))
;
```

**Output:**
```
playerid|namefirst|namelast|salary|yearid
brownke01|Kevin|Brown|15714286.0|2000
rodrial01|Alex|Rodriguez|22000000.0|2001
......
```

<br>

**v.** Each team has at least 1 All Star and may have multiple. For each team in the year 2016, give the `teamid` and `diffAvg` (the difference between the team's highest paid all-star's salary and the team's lowest paid all-star's salary).

* Note: Due to some discrepancies in the database, please draw your team names from the All-Star table (so use `allstarfull.teamid` in the SELECT statement for this).

**Ans:**
```sql
CREATE VIEW q4v(team, diffAvg) AS
  SELECT a.teamid, MAX(salary) - MIN(salary) FROM allstarfull AS a INNER JOIN salaries AS s
  ON a.playerid = s.playerid AND a.yearid = s.yearid WHERE s.yearid = 2016 GROUP BY a.teamid
;
```

**Output:**
```
team|ROUND(diffAvg, 4)
ARI|0.0
ATL|0.0
BAL|14550000.0
BOS|15485500.0
CHA|3750000.0
CHN|24473000.0
CIN|12031666.0
CLE|4163800.0
COL|12428571.0
DET|0.0
HOU|3162000.0
KCA|6250000.0
LAA|0.0
......
```

<br>

## You're done!

Rerun `python3 test.py` to see if you're passing tests.
