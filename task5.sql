/* Количество покемонов каждого типа среди покемонов участников */

SELECT TYPE.TYPE_ID, TYPE.TYPE_NAME, COUNT(POKEMON_ID)
    FROM POKEMON_LEAGUE.TYPE
    LEFT JOIN POKEMON_LEAGUE.POKEMON_X_TYPE ON TYPE.TYPE_ID = POKEMON_X_TYPE.TYPE_ID
    GROUP BY (TYPE.TYPE_ID, TYPE.TYPE_NAME)
    ORDER BY COUNT(POKEMON_ID) DESC;

/* Количество покемонов каждого типа среди участников боёв */

SELECT TYPE.TYPE_ID, TYPE.TYPE_NAME, COUNT(ROUND_X_POKEMON.POKEMON_ID)
    FROM POKEMON_LEAGUE.TYPE
    LEFT JOIN POKEMON_LEAGUE.POKEMON_X_TYPE ON TYPE.TYPE_ID = POKEMON_X_TYPE.TYPE_ID
    LEFT JOIN POKEMON_LEAGUE.ROUND_X_POKEMON ON POKEMON_X_TYPE.POKEMON_ID = ROUND_X_POKEMON.POKEMON_ID
    GROUP BY (TYPE.TYPE_ID, TYPE.TYPE_NAME)
    ORDER BY COUNT(POKEMON_X_TYPE.POKEMON_ID) DESC;

/* Количество раундов в каждой лиге */

SELECT LEAGUE.LEAGUE_ID, LEAGUE_NAME, COUNT(ROUND_ID)
    FROM POKEMON_LEAGUE.LEAGUE
    LEFT JOIN POKEMON_LEAGUE.BATTLE ON LEAGUE.LEAGUE_ID = BATTLE.LEAGUE_ID
    LEFT JOIN POKEMON_LEAGUE.ROUND ON BATTLE.BATTLE_ID = ROUND.BATTLE_ID
    GROUP BY (LEAGUE.LEAGUE_ID, LEAGUE_NAME)
    ORDER BY COUNT(ROUND_ID) DESC;

/* Процент побед для каждого игрока */

SELECT PLAYER.PLAYER_ID, PLAYER.PLAYER_NAME, SUM(CASE WHEN(ROUND.WINNER_ID = PLAYER.PLAYER_ID) THEN 1.0 END) /
                                      COUNT(ROUND_X_PLAYER.ROUND_ID) as PERCENT_OF_WIN
    FROM POKEMON_LEAGUE.ROUND_X_PLAYER
    RIGHT JOIN POKEMON_LEAGUE.ROUND ON ROUND.ROUND_ID = ROUND_X_PLAYER.ROUND_ID
    INNER JOIN POKEMON_LEAGUE.PLAYER ON PLAYER.PLAYER_ID = ROUND_X_PLAYER.PLAYER_ID
    GROUP BY (ROUND_X_PLAYER.PLAYER_ID, PLAYER.PLAYER_ID, PLAYER.PLAYER_NAME)
    ORDER BY PERCENT_OF_WIN DESC;

/* в каком возрасте в среднем по нашим данным покемоны участвуют в 3 и более раундах */

SELECT AVG(POKEMON.AGE)
    FROM POKEMON_LEAGUE.POKEMON
    WHERE POKEMON_ID IN (SELECT POKEMON_ID
    FROM POKEMON_LEAGUE.ROUND_X_POKEMON
    GROUP BY POKEMON_ID
    HAVING COUNT(ROUND_ID) >= 3);