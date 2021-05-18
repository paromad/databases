/* не будем вставлять гендер - пример INSERT */
INSERT INTO POKEMON_LEAGUE.POKEMON(POKEMON_ID, PLAYER_ID, POKEMON_NAME, AGE, HIGH, WEIGHT) VALUES (11, 4, 'Abracadabra', 1, 0.5, 5.78);

/* посмотрим на покемонов участника под номером 4 - пример SELECT */
SELECT POKEMON_NAME, GENDER
FROM POKEMON_LEAGUE.POKEMON
WHERE PLAYER_ID = 4;

/* да на самом деле зачем нам какая-то Абракадабра - пример DELETE */
DELETE FROM POKEMON_LEAGUE.POKEMON
WHERE POKEMON_NAME = 'Abracadabra';

/* Катюша повысила свой уровень - пример UPDATE */
UPDATE POKEMON_LEAGUE.PLAYER
SET STATUS = 'Продолжающий'
WHERE PLAYER_ID = 1;
