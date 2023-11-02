-- MySQL dump 10.13  Distrib 8.0.33, for Linux (x86_64)
--
-- Host: std-mysql    Database: std_1975_exam
-- ------------------------------------------------------
-- Server version	5.7.26-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `year` year(4) NOT NULL,
  `publisher` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `volume` int(11) NOT NULL,
  `cover_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cover_id` (`cover_id`),
  CONSTRAINT `books_ibfk_1` FOREIGN KEY (`cover_id`) REFERENCES `covers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (1,'На западном фронте без перемен','Говоря о Первой мировой войне, всегда вспоминают одно произведение Эриха Марии Ремарка.\r\n«На Западном фронте без перемен».\r\nЭто рассказ о немецких мальчишках, которые под действием патриотической пропаганды идут на войну, не зная о том, что впереди их ждет не слава героев, а инвалидность и смерть…\r\nКаждый день войны уносит жизни чьих-то отцов, сыновей, а газеты тем временем бесстрастно сообщают: «На Западном фронте без перемен…».\r\nЭта книга – не обвинение, не исповедь.\r\nЭто попытка рассказать о поколении, которое погубила война, о тех, кто стал ее жертвой, даже если сумел спастись от снарядов и укрыться от пули.',2015,'АСТ','Эрих Мария Ремарк',288,1),(2,'Психбольница в руках пациентов','Все мы – безумцы, живущие в технологическом сумасшедшем доме, и создали этот безумный мир мы сами. Своими руками сотворили этот кошмар: интерфейсы, которые нас раздражают и утомляют глаза, устройства, которые приводят к болям в спине и в запястьях. Эта книга стала манифестом и до сих пор не потеряла актуальность. Дверь на свободу распахнута. Почему же мы не замечаем выхода? Об этом и рассказывает Алан Купер, объясняя разницу между интерфейсом и взаимодействием.\r\nЭй, ребята, у вас тут полно обозленных клиентов. Вам есть что им ответить?',2018,'Питер','Алан Купер',500,2),(3,'Азбука','Содержание учебника направлено на формирование у обучающихся функциональной грамотности и коммуникативной компетентности.\r\n\r\nОбучение строится на основе коммуникативного подхода. Коммуникативно-речевая ориентация курса предполагает интенсивное развитие всех видов речевого общения: слушания, говорения, чтения и письма. В период обучения грамоте обучающиеся освоят первоначальные основы смыслового чтения, начнут учиться работать с текстом, строить свои высказывания в зависимости от ситуации, составлять свой текст.',2015,'Просвещение','Л. Ф. Климанова, С. Г. Макеева',129,3),(4,'Дневник Глории. 50 ддмс','«Ее зовут **Глория Макфин**. Она обычный подросток с типичными для ее возраста проблемами. И у нее осталось 50 дней для того, чтобы принять самое важное решение в жизни».\n\nВы наверняка узнали эти строки! Этот дневник создан специально для тех, кто с удовольствием прочел про ее путь длиной в 50 дней, полных приключений и переживаний.\n\nОкунитесь снова в мир эмоций: печали, отчаяния, грусти, страха, радости и веселья – и станьте соавтором истории Глории Макфин. В дневнике вы найдете увлекательные задания по мотивам книги, вы сможете лучше понять себя и разобраться в своих мыслях.\n\nГлавное – уделить этому дневнику не один день, ведь заполняя его день за днем, вы поймете, что счастье рядом с вами.',2020,'АСТ','Стейс Крамер',225,4),(5,'Маленький принц','В одном из писем к матери Сент-Экзюпери признался: «Мне ненавистны люди, пишущие ради забавы, ищущие эффектов. Надо иметь что сказать». Ему, романтику неба, не чуравшемуся земных радостей, любившему, по свидетельству друзей, «писать, говорить, петь, играть, докапываться до сути вещей, есть, обращать на себя внимание, ухаживать за женщинами», человеку проницательного ума со своими достоинствами и недостатками, но всегда стоявшему на защите общечеловеческих ценностей, было «что сказать». И он написал самую известную во всем мире сказку «Маленький принц» о самом важном в этой жизни, жизни на планете Земля, все чаще такой неласковой, но любимой и единственной.',2017,'Эксмо','Антуан де Сент-Экзюпери',80,5),(6,'Метро 2033','Двадцать лет спустя Третьей мировой войны последние выжившие люди прячутся на станциях и в туннелях московского метро, самого большого на Земле противоатомного бомбоубежища. Поверхность планеты заражена и непригодна для обитания, и станции метро становятся последним пристанищем для человека. Они превращаются в независимые города-государства, которые соперничают и воюют друг с другом. Они не готовы примириться даже перед лицом новой страшной опасности, которая угрожает всем людям окончательным истреблением. Артем, двадцатилетний парень со станции ВДНХ, должен пройти через все метро, чтобы спасти свой единственный дом – и все человечество.\n\n«Метро 2033» – культовый роман-антиутопия, один из главных российских бестселлеров нулевых. Переведен на 37 иностранных языков, заинтересовал Голливуд, превращен в атмосферные компьютерные блокбастеры, породил целую книжную вселенную и настоящую молодежную субкультуру во всем мире.',2005,'АСТ','Дмитрий Глуховский',650,6),(7,'Пикник на обочине','После внеземного вторжения Земля оказалась поделена на зоны. Вдоль радианта Пильмана расположились территории, опасные для жизни людей. Но чем больше ученые исследовали загадочные участки, тем больше вопросов оставалось без ответов.\n\nГлавным открытием стала находка артефактов, о свойствах которых человечеству только предстоит узнать. Одни оказывались совершенно бесполезными, а другие – опасными, способными исполнять сокровенные желания и менять все, что окружало жителей Земли.\n\nПопытка сталкера Рэдрика Шухарта заработать на жизнь кражей таинственных артефактов оказалась фатальной. Вместо награды ему придется заглянуть в темноту собственной души и попытаться найти хоть что-то светлое, что поможет раскрыть главную тайну человеческого существования.\n\nКнига о бесконечной проблеме нравственного выбора, фантастических приключениях и непростых судьбах. Произведение экранизировано в 1979 году и стало основой для популярной компьютерной игры **«S.T.A.L.K.E.R.».**',2021,'АСТ','Аркадий и Борис Стругацкие',256,7);
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books_collections`
--

DROP TABLE IF EXISTS `books_collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books_collections` (
  `book_id` int(11) NOT NULL,
  `collection_id` int(11) NOT NULL,
  PRIMARY KEY (`book_id`,`collection_id`),
  KEY `collection_id` (`collection_id`),
  CONSTRAINT `books_collections_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE,
  CONSTRAINT `books_collections_ibfk_2` FOREIGN KEY (`collection_id`) REFERENCES `collections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books_collections`
--

LOCK TABLES `books_collections` WRITE;
/*!40000 ALTER TABLE `books_collections` DISABLE KEYS */;
INSERT INTO `books_collections` VALUES (3,1),(5,1),(6,1),(7,1),(1,2),(2,2);
/*!40000 ALTER TABLE `books_collections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books_genres`
--

DROP TABLE IF EXISTS `books_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books_genres` (
  `book_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL,
  PRIMARY KEY (`book_id`,`genre_id`),
  KEY `genre_id` (`genre_id`),
  CONSTRAINT `books_genres_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE,
  CONSTRAINT `books_genres_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books_genres`
--

LOCK TABLES `books_genres` WRITE;
/*!40000 ALTER TABLE `books_genres` DISABLE KEYS */;
INSERT INTO `books_genres` VALUES (1,1),(4,1),(6,1),(7,1),(2,2),(3,2),(5,3),(6,4),(7,4);
/*!40000 ALTER TABLE `books_genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `collections`
--

DROP TABLE IF EXISTS `collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `collections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `collections_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collections`
--

LOCK TABLES `collections` WRITE;
/*!40000 ALTER TABLE `collections` DISABLE KEYS */;
INSERT INTO `collections` VALUES (1,'Любимые',1),(2,'Прочитать',3);
/*!40000 ALTER TABLE `collections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `covers`
--

DROP TABLE IF EXISTS `covers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `covers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) NOT NULL,
  `mime_type` varchar(255) NOT NULL,
  `md5_hash` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `covers`
--

LOCK TABLES `covers` WRITE;
/*!40000 ALTER TABLE `covers` DISABLE KEYS */;
INSERT INTO `covers` VALUES (1,'nazap.jpg','image/jpeg','b6c01d9f2469f60f1dd674a120af6639'),(2,'psih.jpg','image/jpeg','881aed4da2349557e7c3c848d764d98c'),(3,'azbuka.jpg','image/jpeg','effba9f5cb25349a37bd18ff1ffeba52'),(4,'dnevnik.jpg','image/jpeg','79455d33a2d354ffacd5cd358806b3ec'),(5,'malenk.jpg','image/jpeg','56cbe1e165c8b905e6fa400decb1b6af'),(6,'metro.jpg','image/jpeg','313fcd81709f72d3f00452b63073f8e4'),(7,'piknik.jpg','image/jpeg','37ee4d86849b99e77369aa7809c6e7e6'),(39,'tropami.jpg','image/jpeg','9aa2460533fe8835de14e18e2f1333ad'),(40,'tropami.jpg','image/jpeg','d41d8cd98f00b204e9800998ecf8427e');
/*!40000 ALTER TABLE `covers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

LOCK TABLES `genres` WRITE;
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
INSERT INTO `genres` VALUES (1,'Роман'),(2,'Руководство'),(3,'Сказка'),(4,'Фантастика');
/*!40000 ALTER TABLE `genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `book_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `text` text NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `book_id` (`book_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,1,1,4,'Не дочитал до конца, но обязательно это сделаю. Книга хороша','2023-10-27 13:30:13'),(2,1,3,5,'Хорошая книга, никаких претензий','2023-10-27 13:30:13'),(3,2,2,4,'Сложно, очень сложно, но полезно','2023-10-27 13:31:31'),(4,2,3,1,'Скорее всего проблема во мне, но ничему я не научился','2023-10-27 13:31:31'),(5,3,1,5,'Вот это супер!','2023-10-27 13:32:48'),(6,4,2,3,'Ну такое, для подростка - слишком рано, для взрослого - уже не то','2023-10-27 13:32:48'),(7,6,1,5,'Обожаю серию игр Metro, поэтому сразу захотелось почитать. Книга - шедевр','2023-10-27 13:34:08'),(8,6,3,4,'Соглашусь с комментарием Алексея, книга хороша, но есть в ней немного лишнего','2023-10-27 13:35:36'),(9,7,1,5,'Сталкер - это мое все!','2023-10-27 13:35:36'),(10,7,2,3,'Не впечатлило, после одноименной игры книга показалась скучной','2023-10-27 13:36:57'),(11,7,3,1,'Игра намного лучше!','2023-10-27 13:36:57');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Администратор','Может все'),(2,'Модератор','Может редактировать книги'),(3,'Пользователь','Может писать отзывы');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'valov','65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5','Валов','Алексей','Васильевич',1),(2,'moder','b6ad34b0b6b7e38f878a513b3f7927ebeb4cffb01aeb6d9fd9f9ad67fbc76517','Модератор','Модер','Модерович',2),(3,'user','9c6d405bba2db24bfbd22fc7ff74b39bd9c5e9c6ce66299c6519be517e6ed7c6','Пользователь','Юзер','Юзерович',3);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-27 22:47:10
