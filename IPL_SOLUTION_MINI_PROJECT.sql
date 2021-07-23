
#mini project solutions sql file

#1.	Show the percentage of wins of each bidder in the order of highest to lowest percentage.

select bidder_id,(sum(CASE when bid_status="won" then 1
else 0 end ))/(sum(Case when bid_status<>"Cancelled"  and bid_status<>"Bid" then 1
else 0 end ))*100 as win_percentage from IPL_Bidding_Details group by bidder_id
order by win_percentage desc;

#here i am taking into consideration matches which are completed and not in state of cancelled or "bid" .


#2.	Display the number of matches conducted at each stadium with stadium name, city from the database.

select a.stadium_id,b.stadium_name,b.city,count(schedule_id) from 
ipl_match_schedule as a  join ipl_stadium as b on 
a.stadium_id=b.stadium_id  group by a.stadium_id;


#or  considering only completed matches we can use this approach for conducted matches and completed 

select a.stadium_id,b.stadium_name,b.city,count(schedule_id) from 
ipl_match_schedule as a  join ipl_stadium as b on 
a.stadium_id=b.stadium_id where a.status='completed' group by a.stadium_id;


#3.	In a given stadium, what is the percentage of wins by a team which has won the toss?

select a.stadium_id,(((sum(case when b.toss_winner=b.match_winner then 1 else 0 end ))/(count(a.match_id)))*100) as win_percentage from 
IPL_Match_Schedule as a join IPL_Match as b on a.match_id=b.match_id where a.status="completed"
group by a.stadium_id;


#4.	Show the total bids along with bid team and team name.

select a.bid_team ,b.team_name,count(*) as total_bid from 
ipl_bidding_details as a join ipl_team as b 
on a.bid_team=b.team_id
group by a.bid_team ;

#5.	Show the team id who won the match as per the win details.

select (CASE when match_winner=1 then team_id1 else team_id2 end )as winning_team_id ,win_details
from ipl_match;


#6.	Display total matches played, total matches won and total matches lost by team along with its team name.

select a.team_id, b.team_name, sum(a.matches_played) as matches_played, sum(a.matches_won) as matches_won, 
sum(a.matches_lost) as matches_lost
from ipl_team_standings as a join ipl_team as b 
on 
a.team_id=b.team_id
group by team_id;


#7.	Display the bowlers for Mumbai Indians team.

select a.team_id,a.player_id,b.player_name,a.player_role
from ipl_team_players as a join ipl_player as b
on a.player_id=b.player_id
where a.team_id=5 and player_role like "%Bowler%";

#here since team_id of mumbai indias is 5 so i have used that information


#8.	How many all-rounders are there in each team, Display the teams with more than 4 
#all-rounder in descending order.

## part -1 solution:--total count of allrounders in each team 

select a.team_id,b.team_name,count(a.player_role) as count_of_allrounders from
ipl_team_players as a join ipl_team as b on 
a.team_id=b.team_id where a.player_role like "%all-rounder%"
group by a.team_id;


##part 2--- teams with more than 4 all rounders in descending order

select a.team_id,b.team_name,count(a.player_role) as count_of_allrounders from
ipl_team_players as a join ipl_team as b on 
a.team_id=b.team_id where a.player_role like "%all-rounder%"
group by a.team_id
having count_of_allrounders>4
order by count_of_allrounders desc;

