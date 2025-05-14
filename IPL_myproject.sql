create table IPL_matches(id int,city varchar,date date,player_of_match varchar,venue varchar,
neutral_venue int,team1 varchar,team2 varchar,toss_winner varchar,toss_decision varchar,winner varchar,result varchar,result_margin int,eliminator varchar,method varchar,umpire1 varchar,umpire2 varchar);
				
					/*importing work*/
				
copy ipl_matches from 'C:\Program Files\PostgreSQL\15\data\data_copy\IPL Dataset\IPL_matches.csv'delimiter ','csv header;


/* table 2*/

create table ipl_ball(id int,inning int, over int,ball int,batsman varchar,non_striker varchar,
					 bowler varchar,batsman_runs int,extra_runs int,total_runs int,is_wicket int,
					 dismissal_kind varchar,player_dismissed varchar,fielder varchar,
					 extras_type varchar,batting_team varchar,bowling_team varchar);
					 
					 
		/*importing 2nd*/
		
copy ipl_ball from'C:\Program Files\PostgreSQL\15\data\data_copy\IPL Dataset\IPL_Ball.csv'delimiter ','csv header;		

-- tables 
select * from ipl_ball;
select * from ipl_matches;
				
/* strick rate */

select batsman, sum(batsman_runs) as total_runs, count(batsman) balls_played, sum(batsman_runs) * 1.0/count(batsman)*100 as strike_rate from ipl_ball
where extras_type <> 'wides' group by batsman having count(ball)>=500 order by strike_rate desc limit 10;

/* average */

select distinct batsman , sum(a.batsman_runs) as total_run , sum(a.is_wicket) as player_dismissed,
count (distinct (extract (year from b.date))) as season,
sum(a.batsman_runs)/sum(a.is_wicket)*1.0 as aveg
from ipl_ball as a
left Join ipl_matches as b
on a.id = b.id
group by batsman
having count (distinct(extract (year from b.date)))>2 and sum(a.is_wicket)>1
order by aveg desc limit 10;
 


/* hard-hitter*/
 
 
 select * from (select distinct a.batsman, sum(a.batsman_runs)as batsman_total_runs, sum(case when a.batsman_runs=4 then 4
				 when a.batsman_runs=6 then 6 else 0 end ) as boundary_runs,
			   count(distinct(extract(year from b.date))) as seasons,
				sum(case when a.batsman_runs=4 then 4 when a.batsman_runs=6 then 6 else 0 end )*1.0/sum(a.batsman_runs)*100 as boundary_percentage
			   from ipl_ball as a left join ipl_matches as b
				on a.id=b.id group by a.batsman order by boundary_percentage desc) as c
			   where c.seasons>2 limit 10;
			 
			 /*economy */
				
SELECT bowler, SUM(total_runs) AS total_runs_conceded, COUNT(bowler) AS total_no_of_balls,
round((SUM(total_runs)/(COUNT(bowler)/6.0)),2) AS economy
FROM ipl_ball GROUP BY bowler 	HAVING COUNT(bowler)>=500
ORDER BY economy ASC LIMIT 10;


				
				/* strick rate */
				
SELECT bowler, COUNT(bowler) AS total_no_of_balls, SUM(is_wicket) AS total_wickets,
COUNT (bowler)/ SUM(is_wicket) * 1.0 AS strike_rate
FROM ipl_ball WHERE dismissal_kind NOT IN ('run out','obstructing the field','retired hurt')
GROUP BY bowler HAVING COUNT(bowler)>=500 ORDER BY strike_rate ASC LIMIT 10;

               /* all rounder */
			   
select batsman,
round((sum(batsman_runs)*1.0/count(batsman)*100),2) as bats_strike_rate,bowl_strike_rate
 from ipl_ball as a
 inner join(select bowler,count(bowler)as no_of_balls,sum(is_wicket) as wickets_taken,
   round((count(bowler)/sum(is_wicket)*1.0),2) as bowl_strike_rate
   from ipl_ball 
   where dismissal_kind NOT IN('run out','obstructing the field','retired hurt')
   group by bowler having count(bowler)>300 order by bowl_strike_rate asc)as b
   on a.batsman=b.bowler
 where extras_type <> 'wides'
 group by batsman,bowl_strike_rate
 having count(ball)>=500 
 order by bats_strike_rate DESC,bowl_strike_rate asc
 limit 10;			   
 
 /* aditional que */
 
 -- creating new table
 create table Deliveries(id int,inning int, over int,ball int,batsman varchar,non_striker varchar,
					 bowler varchar,batsman_runs int,extra_runs int,total_runs int,is_wicket int,
					 dismissal_kind varchar,player_dismissed varchar,fielder varchar,
					 extras_type varchar,batting_team varchar,bowling_team varchar);
	-- importing data in new table
	
copy Deliveries from'C:\Program Files\PostgreSQL\15\data\data_copy\IPL Dataset\IPL_Ball.csv'delimiter ','csv header;		
					 select * from deliveries;
					 
  -- creating matches table
  create table matches(id int,city varchar,date date,player_of_match varchar,venue varchar,
neutral_venue int,team1 varchar,team2 varchar,toss_winner varchar,toss_decision varchar,winner varchar,result varchar,result_margin int,eliminator varchar,method varchar,umpire1 varchar,umpire2 varchar);
				--importing 
copy matches from 'C:\Program Files\PostgreSQL\15\data\data_copy\IPL Dataset\IPL_matches.csv'delimiter ','csv header;

/* question 1*/

select distinct city, count(city) from matches group by city ;

/* question 2 */

CREATE TABLE deliveries_v02 AS (SELECT * ,
(CASE WHEN total_runs >= 4 THEN 'boundary' WHEN total_runs= 0 THEN 'dot' ELSE 'other' END)
AS ball_result FROM deliveries);
				
				SELECT * FROM deliveries_v02;
/* question 3*/
    SELECT ball_result , 
	COUNT(ball_result) AS ball_count
	FROM deliveries_v02 WHERE ball_result IN ( 'boundary','dot' )
	GROUP BY ball_result;
	
/* question 4 */

     SELECT DISTINCT batting_team,
	 COUNT(ball_result) AS boundary_scored
	 FROM deliveries_v02 
	 WHERE ball_result= 'boundary'
	 GROUP BY batting_team 
	 ORDER BY COUNT(ball_result) DESC;
	 
/* question 5 */
	 
	  select distinct bowling_team , count(ball_result) as dot_ball_bowled from deliveries_v02 
	 where ball_result= 'dot' group by bowling_team order by count(ball_result) desc;
	 
/* question 6 */
    
	 select dismissal_kind,  count( dismissal_kind )as dismissal_type from deliveries_v02 where NOT dismissal_kind ='NA' GROUP BY  dismissal_kind;
	 
/* question 7 */

     select distinct bowler, sum(extra_runs) as exrta_runs_conceded from deliveries_v02 group by bowler order by  sum(extra_runs) desc limit 5;
	 
/* question 8 */

     create table deliveries_v03 as (select a. * , b.venue , b.date as match_date  from deliveries_v02 as a
	left join matches as b on a.id=b.id);
	
	select venue, match_date, ball_result from deliveries_v03;
	
/* question 9 */

     select distinct venue, sum(total_runs) as total_runs_scored from deliveries_v03 group by venue order by sum(total_runs) desc;
	 
/* question 10 */

     select  distinct extract(year from match_date) as year, sum(total_runs) as total_runs  from deliveries_v03
	 where venue = 'Eden Gardens' group by distinct extract(year from match_date)  order by sum(total_runs) desc;