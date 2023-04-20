# M�dos�t�sok
# teamrace: + place (int) eredm�y mez�, id: legyen azonos�t�
# competitionnumbers: + RaceId mez� (melyik verseny)

#A feladatok hozz�k�t�se a versenyhez
update competitionnumbers set racesId = 1;

  call csvGenerator();

select * from races;
select * from teams;
select * from teamrace;
select * from competitionnumbers;

# Az gy�z, akinek kevesebb pontja van
UPDATE competitionnumbers set moreIsBetter = 0;

# 1: az gy�z, akinek t�bb pontja van
UPDATE competitionnumbers set moreIsBetter = 1
  where id in (1, 3, 5, 6);

# pontoz�si alapelv:
#versenysz�monk�nt eredm�ny szerint cs�kken�be rakjuk a csapatokat �s 1-t�l sorsz�mozzuk.

#Adott versenysz�m csapatai
select * from teams t
  inner join teamrace tr on t.id = tr.teamId
  inner join competitionnumbers c on c.id = tr.competitionNumberId
  where RaceId = 1 and c.moreIsBetter = 1 and tr.competitionNumberId = 1
  order by tr.resultNumber;


# mi az aktu�lis verseny?
set @idRacesActual = (SELECT id from races
ORDER BY raceDateFrom desc);

SELECT @idRacesActual;

# egyszer�s�tve: h�ny csapat van?
set @teamsNumber = (SELECT count(*) db FROM teams
  where RaceId = 1);

select @teamsNumber;

# h�ny versenysz�m van?

set @competitionnumbersNumber = (SELECT count(*) FROM competitionnumbers
  where racesId = 1);

SELECT @competitionnumbersNumber;


call proba();

UPDATE teamrace set place = 0;

select * from teams t
  inner join teamrace tr on t.id = tr.teamId
  inner join competitionnumbers c on c.id = tr.competitionNumberId
  where RaceId = 1 and c.moreIsBetter = 1 and tr.competitionNumberId = 1
  order by tr.resultNumber
  ;

select * from teams t
  inner join teamrace tr on t.id = tr.teamId
  inner join competitionnumbers c on c.id = tr.competitionNumberId
  where RaceId = 1 and c.moreIsBetter = 1 
  order by c.raceNumber, tr.resultNumber
  ;

select * from teams t
  inner join teamrace tr on t.id = tr.teamId
  inner join competitionnumbers c on c.id = tr.competitionNumberId
  where RaceId = 1 and c.moreIsBetter = 0
  order by c.raceNumber, tr.resultNumber desc
  ;


select tr.id from teams t
  inner join teamrace tr on t.id = tr.teamId
  inner join competitionnumbers c on c.id = tr.competitionNumberId
  where RaceId = 1 and c.moreIsBetter = 1 and tr.competitionNumberId = 1
  order by tr.resultNumber
  limit 3,1;



# �gy lehet l�ptetni csapatonk�nt 0,1, 1,1, 2,1 ... 7,1 
set @id = (select tr.id id from teams t
  inner join teamrace tr on t.id = tr.teamId
  inner join competitionnumbers c on c.id = tr.competitionNumberId
  where c.moreIsBetter = 1 and tr.competitionNumberId = 1
  order by tr.resultNumber
  limit 2,1);

set @resultNumber = (select tr.resultNumber from teams t
  inner join teamrace tr on t.id = tr.teamId
  inner join competitionnumbers c on c.id = tr.competitionNumberId
  where c.moreIsBetter = 1 and tr.competitionNumberId = 1
  order by tr.resultNumber
  limit 2,1);

select @id, @resultNumber;

update teamrace set place = 4
  where id = @id;

#eredm�ny hirdet�s
SELECT t.temamName, sum(tr.place) place FROM teams t
  INNER JOIN teamrace tr ON t.id=tr.teamId
  WHERE t.RaceId = 1
  GROUP BY t.temamName
  ORDER BY place desc
  ;


# 1. teamrace gener�l�s

update  teamrace
  SET resultNumber = 100000
  where id in (select t.id from teamrace t 
  INNER JOIN competitionnumbers c ON c.id = t.competitionNumberId
  where c.moreIsBetter = 0);
      