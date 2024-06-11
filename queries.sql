-- Before running drop any existing views
DROP VIEW IF EXISTS q0;
DROP VIEW IF EXISTS q1i;
DROP VIEW IF EXISTS q1ii;
DROP VIEW IF EXISTS q1iii;
DROP VIEW IF EXISTS q1iv;
DROP VIEW IF EXISTS q2i;
DROP VIEW IF EXISTS q2ii;
DROP VIEW IF EXISTS q2iii;
DROP VIEW IF EXISTS q3i;
DROP VIEW IF EXISTS q3ii;
DROP VIEW IF EXISTS q3iii;
DROP VIEW IF EXISTS q4i;
DROP VIEW IF EXISTS q4ii;
DROP VIEW IF EXISTS q4iii;
DROP VIEW IF EXISTS q4iv;
DROP VIEW IF EXISTS q4v;

-- Question 0
CREATE VIEW q0(era)
AS
  SELECT MAX(era) FROM pitching
;

-- Question 1i
CREATE VIEW q1i(namefirst, namelast, birthyear)
AS
  SELECT namefirst, namelast, birthyear FROM people WHERE weight > 300
;

-- Question 1ii
CREATE VIEW q1ii(namefirst, namelast, birthyear)
AS
  SELECT namefirst, namelast, birthyear FROM people WHERE namefirst LIKE '% %'
  ORDER BY namefirst, namelast
;

-- Question 1iii
CREATE VIEW q1iii(birthyear, avgheight, count)
AS
  SELECT birthyear, AVG(height), COUNT(*) FROM people GROUP BY birthyear
  ORDER BY birthyear
;

-- Question 1iv
CREATE VIEW q1iv(birthyear, avgheight, count)
AS
  SELECT birthyear, AVG(height), COUNT(*) FROM people
  GROUP BY birthyear HAVING AVG(height) > 70 ORDER BY birthyear
;

-- Question 2i
CREATE VIEW q2i(namefirst, namelast, playerid, yearid)
AS
  SELECT p.namefirst, p.namelast, h.playerid, h.yearid
  FROM people AS p INNER JOIN halloffame AS h ON p.playerid = h.playerid
  WHERE h.inducted = 'Y'
  ORDER BY h.yearid DESC, h.playerid
;

-- Question 2ii
CREATE VIEW q2ii(namefirst, namelast, playerid, schoolid, yearid)
AS
  SELECT p.namefirst, p.namelast, h.playerid, s.schoolid, h.yearid FROM people AS p
  INNER JOIN halloffame AS h ON p.playerid = h.playerid INNER JOIN collegeplaying
      AS c ON p.playerid = c.playerid INNER JOIN schools AS s ON c.schoolid = s.schoolid
  WHERE h.inducted = 'Y' AND s.schoolstate = 'CA'
  ORDER BY h.yearid DESC, s.schoolid, h.playerid
;

-- Question 2iii
CREATE VIEW q2iii(playerid, namefirst, namelast, schoolid)
AS
  SELECT p.playerid, p.namefirst, p.namelast, c.schoolid FROM people AS p
  INNER JOIN halloffame AS h ON p.playerid = h.playerid LEFT JOIN collegeplaying
      AS c ON p.playerid = c.playerid
  WHERE h.inducted = 'Y' ORDER BY h.playerid DESC, c.schoolid
;

-- Question 3i
CREATE VIEW q3i(playerid, namefirst, namelast, yearid, slg)
AS
  SELECT p.playerid, p.namefirst, p.namelast, b.yearid,
    CAST(SUM(b.H-b.H2B-b.H3B-b.HR)+2*SUM(b.H2B)+3*SUM(b.H3B)+4*SUM(b.HR) AS FLOAT)
      / CAST(SUM(b.AB) AS FLOAT) AS slg
  FROM people AS p INNER JOIN batting AS b ON p.playerid = b.playerid
  WHERE b.AB > 50 GROUP BY p.playerid, p.namefirst, p.namelast, b.yearid, b.teamid
  ORDER BY slg DESC, b.yearid, b.playerid LIMIT 10
;

-- Question 3ii
CREATE VIEW q3ii(playerid, namefirst, namelast, lslg)
AS
  SELECT p.playerid, p.namefirst, p.namelast,
    CAST(SUM(b.H-b.H2B-b.H3B-B.HR)+2*SUM(b.H2B)+3*SUM(b.H3B)+4*SUM(b.HR) AS FLOAT)
      / CAST(SUM(b.AB) AS FLOAT) AS lslg
  FROM people AS p INNER JOIN batting AS b ON p.playerid = b.playerid
  GROUP BY p.playerid HAVING SUM(b.AB) > 50 ORDER BY lslg DESC, p.playerid
  LIMIT 10
;

-- Question 3iii
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

-- Question 4i
CREATE VIEW q4i(yearid, min, max, avg)
AS
  SELECT yearid, MIN(salary), MAX(salary), AVG(salary) FROM salaries GROUP BY yearid
  ORDER BY yearid
;

-- Question 4ii
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

-- Question 4iii
CREATE VIEW q4iii(yearid, mindiff, maxdiff, avgdiff)
AS
  WITH stat(yearid, min_salary, max_salary, avg_salary) AS (
    SELECT yearid, MIN(salary), MAX(salary), AVG(salary) FROM salaries GROUP BY yearid
  )
  SELECT s1.yearid, s1.min_salary - s0.min_salary, s1.max_salary - s0.max_salary,
    s1.avg_salary - s0.avg_salary
  FROM stat AS s0 INNER JOIN stat AS s1 ON s1.yearid = s0.yearid+1 ORDER BY s1.yearid
;

-- Question 4iv
CREATE VIEW q4iv(playerid, namefirst, namelast, salary, yearid)
AS
  SELECT p.playerid, p.namefirst, p.namelast, s.salary, s.yearid FROM people AS p
  INNER JOIN salaries AS s ON p.playerid = s.playerid
  WHERE (s.yearid = 2000 AND s.salary = (SELECT MAX(salary) FROM salaries WHERE yearid = 2000))
    OR (s.yearid = 2001 AND s.salary = (SELECT MAX(salary) FROM salaries WHERE yearid = 2001))
;

-- Question 4v
CREATE VIEW q4v(team, diffAvg) AS
  SELECT a.teamid, MAX(salary) - MIN(salary) FROM allstarfull AS a INNER JOIN salaries AS s
  ON a.playerid = s.playerid AND a.yearid = s.yearid WHERE s.yearid = 2016 GROUP BY a.teamid
;
