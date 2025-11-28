-- Добавление пяти новых пользователей (себя и четырех соседей по группе)
INSERT INTO users (name, email, gender, register_date, occupation_id)
VALUES
('Лемясев Роман', 'r.lemyasev@gmail.com', 'male', date('now'),  (SELECT id FROM occupations WHERE name = 'student')),
('Альвина Кучина', 'a.kuchina@gmail.com', 'female', date('now'), (SELECT id FROM occupations WHERE name = 'student')),
('Максим Ларькин', 'm.larkin@gmail.com', 'male', date('now'), (SELECT id FROM occupations WHERE name = 'student')),
('Максим Лузин', 'm.luzin@mail.com', 'male', date('now'), (SELECT id FROM occupations WHERE name = 'student')),
('Михаил Марьин', 'm.marin@mail.com', 'male', date('now'), (SELECT id FROM occupations WHERE name = 'student'));

-- Добавление фильмов
INSERT INTO movies (title, year)
VALUES
('Галактические скитальцы', 2024),
('Призрачная тень', 2024),
('Улыбки в дождь', 2024);

INSERT INTO movies_genres (movie_id, genre_id)
VALUES
((SELECT id FROM movies WHERE title = 'Галактические скитальцы'),
 (SELECT id FROM genres WHERE name = 'Sci-Fi')),
((SELECT id FROM movies WHERE title = 'Галактические скитальцы'),
 (SELECT id FROM genres WHERE name = 'Adventure')),

((SELECT id FROM movies WHERE title = 'Призрачная тень'),
 (SELECT id FROM genres WHERE name = 'Mystery')),
((SELECT id FROM movies WHERE title = 'Призрачная тень'),
 (SELECT id FROM genres WHERE name = 'Drama')),

((SELECT id FROM movies WHERE title = 'Улыбки в дождь'),
 (SELECT id FROM genres WHERE name = 'Comedy')),
((SELECT id FROM movies WHERE title = 'Улыбки в дождь'),
 (SELECT id FROM genres WHERE name = 'Romance'));

-- Добавление отзывов
INSERT INTO ratings (user_id, movie_id, rating, timestamp)
VALUES
((SELECT id FROM users WHERE email = 'r.lemyasev@gmail.com'),
 (SELECT id FROM movies WHERE title = 'Галактические скитальцы'), 4.6, strftime('%s', 'now')),
((SELECT id FROM users WHERE email = 'r.lemyasev@gmail.com'),
 (SELECT id FROM movies WHERE title = 'Призрачная тень'), 4.8, strftime('%s', 'now')),
((SELECT id FROM users WHERE email = 'r.lemyasev@gmail.com'),
 (SELECT id FROM movies WHERE title = 'Улыбки в дождь'), 4.3, strftime('%s', 'now'));

-- Добавление тегов
INSERT INTO tags (user_id, movie_id, tag, timestamp)
VALUES
((SELECT id FROM users WHERE email = 'r.lemyasev@gmail.com'),
 (SELECT id FROM movies WHERE title = 'Галактические скитальцы'), 'космическое путешествие технологии', strftime('%s', 'now')),
((SELECT id FROM users WHERE email = 'r.lemyasev@gmail.com'),
 (SELECT id FROM movies WHERE title = 'Призрачная тень'), 'мистика загадочный сюжет', strftime('%s', 'now')),
((SELECT id FROM users WHERE email = 'r.lemyasev@gmail.com'),
 (SELECT id FROM movies WHERE title = 'Улыбки в дождь'), 'веселый романтичный жизненный', strftime('%s', 'now'));