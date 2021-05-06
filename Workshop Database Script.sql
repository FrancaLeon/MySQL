CAR WORKSHOP

CREATE DATABASE WORKSHOP;

USE WORKSHOP;

CREATE TABLE CLIENT(
	NAME VARCHAR(100) NOT NULL,
	EMAIL VARCHAR(50) NOT NULL,
	SSN CHAR(9) NOT NULL
);

CREATE TABLE PHONE(
	NUM CHAR(10),
	TYPE CHAR(3)
);

CREATE TABLE CAR(
	MODEL VARCHAR(50) NOT NULL,
	YEAR CHAR(4) NOT NULL,
	BRAND VARCHAR(30) NOT NULL,
	MILEAGE INT(7) NOT NULL
);

CREATE TABLE COLOR(
	TINT VARCHAR(20) NOT NULL,
	PLUS VARCHAR(50)
);

/* ADDING CONSTRAINTS AND KEYS */
ALTER TABLE CLIENT
ADD IDCLIENT INT PRIMARY KEY AUTO_INCREMENT FIRST;

/* ----------------- */

ALTER TABLE PHONE
ADD ID_CLIENT INT FIRST;

ALTER TABLE PHONE ADD CONSTRAINT FK_CLIENT_PHONE
FOREIGN KEY(ID_CLIENT) REFERENCES CLIENT(IDCLIENT); /* CONSTRAINT */

/* ------------------ */

ALTER TABLE CAR
ADD ID_CLIENT INT FIRST;

ALTER TABLE CAR ADD CONSTRAINT FK_CLIENT_CAR
FOREIGN KEY(ID_CLIENT) REFERENCES CLIENT(IDCLIENT);

ALTER TABLE CAR 
ADD IDCAR INT PRIMARY KEY AUTO_INCREMENT AFTER ID_CLIENT;

/* ------------------ */

ALTER TABLE COLOR
ADD ID_CAR INT FIRST;

ALTER TABLE COLOR ADD CONSTRAINT FK_CAR_COLOR
FOREIGN KEY(ID_CAR) REFERENCES CAR(ID_CLIENT);


/* 
USING INFORMATION_SCHEMA TO VERIFY CONSTRAINTS

USE INFORMATION_SCHEMA;

SELECT * FROM TABLE_CONSTRAINTS WHERE CONSTRAINT_SCHEMA = 'WORKSHOP';

+--------------------+-------------------+-----------------+--------------+------------+-----------------+----------+
| CONSTRAINT_CATALOG | CONSTRAINT_SCHEMA | CONSTRAINT_NAME | TABLE_SCHEMA | TABLE_NAME | CONSTRAINT_TYPE | ENFORCED |
+--------------------+-------------------+-----------------+--------------+------------+-----------------+----------+
| def                | workshop          | PRIMARY         | workshop     | car        | PRIMARY KEY     | YES      |
| def                | workshop          | FK_CLIENT_CAR   | workshop     | car        | FOREIGN KEY     | YES      |
| def                | workshop          | PRIMARY         | workshop     | client     | PRIMARY KEY     | YES      |
| def                | workshop          | FK_CAR_COLOR    | workshop     | color      | FOREIGN KEY     | YES      |
| def                | workshop          | FK_CLIENT_PHONE | workshop     | phone      | FOREIGN KEY     | YES      |
+--------------------+-------------------+-----------------+--------------+------------+-----------------+----------+

*/
/* CREATING PROCEDURES TO DATA INSERTION */

DELIMITER $

CREATE PROCEDURE CLIENT_INSERT (IN INSERT_NAME VARCHAR(100),IN INSERT_EMAIL VARCHAR(50),IN INSERT_SSN CHAR(9))
							
	BEGIN
	INSERT INTO CLIENT(IDCLIENT, NAME, EMAIL, SSN) VALUES(NULL,INSERT_NAME, INSERT_EMAIL, INSERT_SSN);
	END $

CREATE PROCEDURE PHONE_INSERT (IN INSERT_CLIENT_PHONE_ID INT, IN INSERT_NUM CHAR(10), IN INSERT_TYPE CHAR(3))
	
	BEGIN
	INSERT INTO PHONE(ID_CLIENT, NUM, TYPE) VALUES(INSERT_CLIENT_PHONE_ID, INSERT_NUM, INSERT_TYPE);
	END $

CREATE PROCEDURE CAR_INSERT (IN INSERT_CLIENT_CAR_ID INT, IN INSERT_CAR_MODEL VARCHAR(50), INSERT_YEAR CHAR(4), INSERT_BRAND VARCHAR(30), INSERT_MILEAGE INT)

	BEGIN
	INSERT INTO CAR(ID_CLIENT, MODEL, YEAR, BRAND, MILEAGE) VALUES
	(INSERT_CLIENT_CAR_ID, INSERT_CAR_MODEL, INSERT_YEAR, INSERT_BRAND, INSERT_MILEAGE);
	END $

CREATE PROCEDURE COLOR_INSERT(IN INSERT_COLOR_CAR_ID INT,IN INSERT_TINT VARCHAR(20), IN INSERT_PLUS VARCHAR(50))

	BEGIN
	INSERT INTO COLOR(ID_CAR, TINT, PLUS) VALUES(INSERT_COLOR_CAR_ID,INSERT_TINT, INSERT_PLUS);
	END $

DELIMITER ;
/* CREATING VIEWS */

/* RETURN ALL CLIENTS THAT HAVE PHONE NUMBER */
CREATE VIEW ALL_PHONE_CLIENTS AS
SELECT CLIENT.IDCLIENT, CLIENT.NAME, CLIENT.EMAIL, CLIENT.SSN,
	   CAR.BRAND, CAR.YEAR, CAR.MODEL, CAR.MILEAGE,
	   COLOR.TINT, IFNULL(COLOR.PLUS,'NOT HAVE'),
	   PHONE.NUM, PHONE.TYPE
FROM CLIENT
INNER JOIN CAR
ON CLIENT.IDCLIENT = CAR.ID_CLIENT
INNER JOIN COLOR
ON CLIENT.IDCLIENT = COLOR.ID_CAR
INNER JOIN PHONE
ON CLIENT.IDCLIENT = PHONE.ID_CLIENT; 

/* RETURN ALL CLIENTS */

CREATE VIEW TOTAL_REPORT AS
SELECT CLIENT.IDCLIENT, CLIENT.NAME, CLIENT.EMAIL, CLIENT.SSN,
	   CAR.BRAND, CAR.YEAR, CAR.MODEL, CAR.MILEAGE,
	   COLOR.TINT, IFNULL(COLOR.PLUS, 'NOT HAVE') AS 'PLUS',
	   IFNULL(PHONE.NUM, 'NOT INFORMED') AS 'PHONE', IFNULL(PHONE.TYPE, 'NOT INFORMED') AS 'TYPE'
FROM CLIENT
INNER JOIN CAR
ON CLIENT.IDCLIENT = CAR.ID_CLIENT
INNER JOIN COLOR
ON CLIENT.IDCLIENT = COLOR.ID_CAR
LEFT JOIN PHONE
ON CLIENT.IDCLIENT = PHONE.ID_CLIENT;


/* RANDOM DATA INSERTION - GENERATED ON www.generatedata.com */

/* CLIENT */
CALL CLIENT_INSERT("Ulysses R. Mccray","lectus@eutellus.org","016905796");
CALL CLIENT_INSERT("Anjolie K. Sweeney","feugiat.placerat.velit@egestas.edu","275555597");
CALL CLIENT_INSERT("Simon F. Taylor","vel.quam@nulla.net","923072664");
CALL CLIENT_INSERT("Quyn L. Conway","torquent@aliquameuaccumsan.com","133618504");
CALL CLIENT_INSERT("Amy X. Gibson","amet@tortorat.ca","492512611");
CALL CLIENT_INSERT("Fulton L. Pierce","magna.tellus@elitpharetra.co.uk","627282882");
CALL CLIENT_INSERT("Nathaniel E. Burris","auctor@nislsem.com","050585769");
CALL CLIENT_INSERT("Savannah J. Stein","Ut.tincidunt@liberomaurisaliquam.com","622330116");
CALL CLIENT_INSERT("Jordan L. Koch","sem.ut@mi.edu","031354848");
CALL CLIENT_INSERT("Jordan U. Mason","Sed@estacfacilisis.edu","936706282");
CALL CLIENT_INSERT("Barrett S. Hoover","neque@massa.co.uk","129193413");
CALL CLIENT_INSERT("Quin B. Hyde","Fusce@mieleifendegestas.com","028752855");
CALL CLIENT_INSERT("Natalie Z. Cruz","quis.diam.luctus@vehicula.com","658695762");
CALL CLIENT_INSERT("Hanna W. Hansen","Proin@acmattisornare.edu","876709866");
CALL CLIENT_INSERT("Tad C. Kirby","accumsan.convallis@Proin.org","108600586");
CALL CLIENT_INSERT("Catherine B. Knapp","aliquet.Phasellus@VivamusnisiMauris.org","256356080");
CALL CLIENT_INSERT("Herman W. Morrow","facilisi@ultriciessem.com","043524917");
CALL CLIENT_INSERT("Phelan B. Olsen","sociis@ametrisus.org","263292187");
CALL CLIENT_INSERT("Tanisha O. Smith","turpis@Fuscealiquam.org","238880306");
CALL CLIENT_INSERT("Kyle N. Ortega","Fusce.dolor.quam@litoratorquent.net","413799115");
CALL CLIENT_INSERT("Melodie U. Knight","lacus.Mauris.non@maurissit.org","607923539");
CALL CLIENT_INSERT("Axel Z. Terrell","aliquam.enim.nec@Crasvehiculaaliquet.com","832525315");
CALL CLIENT_INSERT("Mannix V. Austin","justo@eros.co.uk","190590620");
CALL CLIENT_INSERT("Hop M. Mcclain","lorem.tristique.aliquet@mattisvelitjusto.net","864354626");
CALL CLIENT_INSERT("Kirestin U. Leach","Curabitur@nisl.ca","237975552");
CALL CLIENT_INSERT("Riley J. Greer","amet.diam@anunc.co.uk","139769640");
CALL CLIENT_INSERT("Jenette U. Lynch","commodo.tincidunt.nibh@sitamet.net","006040224");
CALL CLIENT_INSERT("Travis B. Tucker","ac@vulputateposuerevulputate.ca","455241885");
CALL CLIENT_INSERT("Quamar O. Chen","senectus.et@imperdiet.edu","658278718");
CALL CLIENT_INSERT("Lacy F. Buck","leo.Morbi@sit.co.uk","631944386");
CALL CLIENT_INSERT("Fatima H. Hahn","nunc.id@magnaPhasellusdolor.com","906380860");
CALL CLIENT_INSERT("Iliana L. Levine","vel.arcu.eu@faucibus.net","744131194");
CALL CLIENT_INSERT("Duncan K. Workman","lacus@nasceturridiculusmus.com","453846933");
CALL CLIENT_INSERT("Carolyn P. Mckay","ac.fermentum.vel@lectusconvallis.edu","311968424");
CALL CLIENT_INSERT("Dieter X. Sosa","ante@tristique.edu","320617996");
CALL CLIENT_INSERT("Gretchen X. Macdonald","sed.libero@elit.com","976581017");
CALL CLIENT_INSERT("Ahmed P. Nicholson","nec@euismodurnaNullam.edu","385568431");
CALL CLIENT_INSERT("Dante O. Sosa","sed.sapien.Nunc@fermentumfermentum.com","021361811");
CALL CLIENT_INSERT("Malik U. Cunningham","Nunc.ullamcorper@tortorNunccommodo.co.uk","534077912");
CALL CLIENT_INSERT("Hedwig G. Mullins","facilisis.lorem@est.net","760231084");
CALL CLIENT_INSERT("Haley D. Wolf","risus@sempereratin.com","584761860");
CALL CLIENT_INSERT("Inga B. Hayden","id.mollis@dui.com","735211823");
CALL CLIENT_INSERT("Dieter X. Carver","Nunc@ornarefacilisiseget.ca","161089578");
CALL CLIENT_INSERT("Ivory B. Kaufman","ante.iaculis@etpede.org","018617886");
CALL CLIENT_INSERT("Dean V. Johnson","elit@Duismienim.com","763309895");
CALL CLIENT_INSERT("Aquila K. Cochran","libero@luctus.co.uk","260647029");
CALL CLIENT_INSERT("Grant Z. Kirk","bibendum.sed@bibendumfermentum.co.uk","669624942");
CALL CLIENT_INSERT("Noble S. England","libero@tellusidnunc.org","562133264");
CALL CLIENT_INSERT("Josephine P. Daugherty","et.euismod@risus.com","102647641");
CALL CLIENT_INSERT("Rae K. Park","pharetra.sed@nonnisiAenean.co.uk","763398245");
CALL CLIENT_INSERT("Miriam A. Meyer","non.hendrerit.id@temporaugue.org","098834229");
CALL CLIENT_INSERT("Malik F. Jackson","enim@dignissim.net","632544805");
CALL CLIENT_INSERT("Odysseus F. Hyde","lorem.luctus@eleifendnuncrisus.ca","929699940");
CALL CLIENT_INSERT("Buckminster H. Robinson","risus@ornarefacilisis.net","539358259");
CALL CLIENT_INSERT("Freya I. Wells","mi.eleifend@Pellentesqueultriciesdignissim.org","792068082");
CALL CLIENT_INSERT("Basil Z. Solomon","dolor@montesnascetur.net","473414944");
CALL CLIENT_INSERT("Leslie W. Garner","Etiam@malesuada.ca","880239371");
CALL CLIENT_INSERT("Christine N. Cantu","Donec@Sedeu.com","882053531");
CALL CLIENT_INSERT("Danielle Q. Brown","Class.aptent@sitametrisus.net","167417799");
CALL CLIENT_INSERT("Hedwig A. Cross","dolor.sit.amet@scelerisque.edu","521036939");
CALL CLIENT_INSERT("Barclay M. Lancaster","eleifend@dapibusquamquis.ca","873625693");
CALL CLIENT_INSERT("Ishmael Z. Mays","adipiscing.enim@aultriciesadipiscing.org","521604116");
CALL CLIENT_INSERT("Elmo A. Bradford","accumsan.convallis@Nullamvelit.co.uk","393402243");
CALL CLIENT_INSERT("Nash B. Freeman","felis.Nulla@libero.ca","925900532");
CALL CLIENT_INSERT("Ryan X. Savage","et.malesuada@eget.net","845601772");
CALL CLIENT_INSERT("Ginger N. Palmer","risus.quis.diam@ac.co.uk","239885551");
CALL CLIENT_INSERT("Sade L. Mayo","mauris@tristiquepellentesque.net","764739801");
CALL CLIENT_INSERT("Brendan P. Shelton","vitae.aliquet@velitPellentesque.ca","056389679");
CALL CLIENT_INSERT("Bruno O. Mcbride","malesuada@non.edu","294778188");
CALL CLIENT_INSERT("Catherine D. Harmon","ante.iaculis@utipsum.com","924904618");
CALL CLIENT_INSERT("Tanner U. Duke","luctus.et.ultrices@utcursus.org","834264350");
CALL CLIENT_INSERT("Zenaida G. Beck","Maecenas.ornare.egestas@hendrerit.co.uk","484919048");
CALL CLIENT_INSERT("Yoshio I. Mendez","lorem.ac@magnisdisparturient.org","731116034");
CALL CLIENT_INSERT("Lois Z. Herrera","Nunc.mauris@elitpellentesquea.com","468665765");
CALL CLIENT_INSERT("Iris C. Fitzpatrick","Class@felisorciadipiscing.org","087422127");
CALL CLIENT_INSERT("Colt O. Vasquez","natoque.penatibus.et@tortorInteger.org","656167616");
CALL CLIENT_INSERT("Germaine O. Rodriquez","semper.Nam.tempor@ami.com","199241753");
CALL CLIENT_INSERT("Leah G. Mccormick","Nullam.scelerisque@faucibusorci.com","143383206");
CALL CLIENT_INSERT("Reagan Q. Tran","Proin.nisl.sem@aenimSuspendisse.ca","770856516");
CALL CLIENT_INSERT("Maxine F. Rodriguez","dictum.eu.placerat@amet.edu","295508881");
CALL CLIENT_INSERT("Ira P. Barker","dis.parturient.montes@cursusInteger.ca","853918399");
CALL CLIENT_INSERT("Isadora W. Navarro","Curabitur.consequat@loremsemperauctor.org","960518934");
CALL CLIENT_INSERT("Brenden I. Soto","pede.sagittis@enim.net","302759188");
CALL CLIENT_INSERT("Tatyana N. Mcdowell","convallis.convallis.dolor@convalliserateget.co.uk","158996942");
CALL CLIENT_INSERT("Quinlan Z. Burnett","Morbi@Proinvelnisl.edu","209313279");
CALL CLIENT_INSERT("Kerry E. Hobbs","odio@id.ca","134641398");
CALL CLIENT_INSERT("Holly F. Fitzgerald","Suspendisse.eleifend@egestasurna.co.uk","902506211");
CALL CLIENT_INSERT("Zelda U. Brown","eu@Proinvelnisl.edu","215459496");
CALL CLIENT_INSERT("Lisandra E. Chavez","turpis@sapiencursus.co.uk","576433924");
CALL CLIENT_INSERT("Deacon P. Hester","eu.dolor.egestas@arcu.com","357151315");
CALL CLIENT_INSERT("Rinah Y. Lawrence","magna.Praesent.interdum@lectusconvallisest.org","966931461");
CALL CLIENT_INSERT("Lara V. Burris","commodo@orci.edu","488606419");
CALL CLIENT_INSERT("Nell I. Copeland","lorem@malesuadafringilla.net","643408313");
CALL CLIENT_INSERT("Kevyn Y. Durham","tincidunt.nunc@acturpisegestas.ca","943935270");
CALL CLIENT_INSERT("Channing B. Downs","vitae.aliquam.eros@orcilobortisaugue.net","814008660");
CALL CLIENT_INSERT("Justine I. Jarvis","est.Mauris.eu@sed.net","328703731");
CALL CLIENT_INSERT("Octavia D. Bush","consectetuer.mauris.id@non.net","003422516");
CALL CLIENT_INSERT("Jordan B. Morrison","Nulla.tincidunt.neque@consectetuerrhoncusNullam.com","987407517");
CALL CLIENT_INSERT("Zephania V. Conner","blandit.Nam.nulla@accumsan.net","758869697");
CALL CLIENT_INSERT("Cheryl G. Odom","commodo@ultricesposuerecubilia.edu","155733736");

/* PHONE */

CALL PHONE_INSERT(0,"8683269985","COM");
CALL PHONE_INSERT(2,"5716041034","RES");
CALL PHONE_INSERT(4,"1804600313","RES");
CALL PHONE_INSERT(6,"9005103691","RES");
CALL PHONE_INSERT(8,"7987386441","TEL");
CALL PHONE_INSERT(10,"7274914717","COM");
CALL PHONE_INSERT(12,"4559131992","COM");
CALL PHONE_INSERT(14,"2757906973","TEL");
CALL PHONE_INSERT(16,"9867854326","COM");
CALL PHONE_INSERT(18,"7371293687","COM");
CALL PHONE_INSERT(20,"1795580799","RES");
CALL PHONE_INSERT(22,"5848391861","COM");
CALL PHONE_INSERT(24,"8103575357","COM");
CALL PHONE_INSERT(26,"2658594036","RES");
CALL PHONE_INSERT(28,"6882472756","COM");
CALL PHONE_INSERT(30,"5438270812","COM");
CALL PHONE_INSERT(32,"7629363612","TEL");
CALL PHONE_INSERT(34,"8118678655","COM");
CALL PHONE_INSERT(36,"1238258922","TEL");
CALL PHONE_INSERT(38,"7892605531","COM");
CALL PHONE_INSERT(40,"7309595712","TEL");
CALL PHONE_INSERT(42,"8202896173","COM");
CALL PHONE_INSERT(44,"2518055945","RES");
CALL PHONE_INSERT(46,"7114343872","TEL");
CALL PHONE_INSERT(48,"2893606371","COM");
CALL PHONE_INSERT(50,"9202364146","COM");
CALL PHONE_INSERT(52,"9408813391","TEL");
CALL PHONE_INSERT(54,"7346996413","RES");
CALL PHONE_INSERT(56,"4106790857","COM");
CALL PHONE_INSERT(58,"6841795385","TEL");
CALL PHONE_INSERT(60,"3727376281","COM");
CALL PHONE_INSERT(62,"1912315852","RES");
CALL PHONE_INSERT(64,"7816937539","TEL");
CALL PHONE_INSERT(66,"7052529542","RES");
CALL PHONE_INSERT(68,"8211318445","COM");
CALL PHONE_INSERT(70,"5647893802","COM");
CALL PHONE_INSERT(72,"5041228462","RES");
CALL PHONE_INSERT(74,"9162981824","TEL");
CALL PHONE_INSERT(76,"2512407109","RES");
CALL PHONE_INSERT(78,"2745761378","RES");
CALL PHONE_INSERT(80,"1888663054","COM");
CALL PHONE_INSERT(82,"2635000117","COM");
CALL PHONE_INSERT(84,"7829486082","COM");
CALL PHONE_INSERT(86,"9193281977","COM");
CALL PHONE_INSERT(88,"7528657808","TEL");

/* CAR */

CALL CAR_INSERT (1,1,"2010","Smart","88.927");
CALL CAR_INSERT (2,5,"1997","JLR","01.944");
CALL CAR_INSERT (3,4,"2010","Subaru","94.905");
CALL CAR_INSERT (4,5,"2003","General Motors","19.693");
CALL CAR_INSERT (5,4,"2002","Tata Motors","13.585");
CALL CAR_INSERT (6,4,"2001","Lexus","53.672");
CALL CAR_INSERT (7,5,"2013","Acura","90.392");
CALL CAR_INSERT (8,1,"2005","Audi","70.481");
CALL CAR_INSERT (9,5,"2021","Mahindra and Mahindra","31.596");
CALL CAR_INSERT (10,3,"2016","Citroën","56.838");
CALL CAR_INSERT (11,2,"1987","Toyota","63.007");
CALL CAR_INSERT (12,1,"1987","Lexus","55.750");
CALL CAR_INSERT (13,3,"2022","Mahindra and Mahindra","40.904");
CALL CAR_INSERT (14,5,"1991","MINI","56.399");
CALL CAR_INSERT (15,4,"2020","General Motors","63.392");
CALL CAR_INSERT (16,4,"1998","Lincoln","59.083");
CALL CAR_INSERT (17,3,"2010","Ford","12.482");
CALL CAR_INSERT (18,1,"1998","Audi","48.219");
CALL CAR_INSERT (19,2,"2009","Volkswagen","56.989");
CALL CAR_INSERT (20,5,"2017","Ford","92.429");
CALL CAR_INSERT (21,5,"1989","Lexus","97.959");
CALL CAR_INSERT (22,2,"2014","FAW","56.241");
CALL CAR_INSERT (23,4,"2001","RAM Trucks","71.553");
CALL CAR_INSERT (24,1,"1988","Nissan","18.191");
CALL CAR_INSERT (25,5,"1999","Suzuki","01.207");
CALL CAR_INSERT (26,1,"2003","Infiniti","34.687");
CALL CAR_INSERT (27,5,"1991","Isuzu","30.234");
CALL CAR_INSERT (28,3,"1994","RAM Trucks","90.575");
CALL CAR_INSERT (29,4,"2003","RAM Trucks","70.773");
CALL CAR_INSERT (30,5,"2000","Mahindra and Mahindra","64.890");
CALL CAR_INSERT (31,1,"1998","Toyota","12.057");
CALL CAR_INSERT (32,1,"2002","Mercedes-Benz","78.977");
CALL CAR_INSERT (33,3,"1995","FAW","10.933");
CALL CAR_INSERT (34,2,"2008","Mercedes-Benz","56.280");
CALL CAR_INSERT (35,2,"2016","Tata Motors","42.583");
CALL CAR_INSERT (36,2,"1995","Daihatsu","59.677");
CALL CAR_INSERT (37,1,"2016","Volvo","33.558");
CALL CAR_INSERT (38,4,"2005","Mahindra and Mahindra","13.966");
CALL CAR_INSERT (39,4,"1991","Vauxhall","29.054");
CALL CAR_INSERT (40,4,"1996","Nissan","27.469");
CALL CAR_INSERT (41,5,"2019","Tata Motors","90.599");
CALL CAR_INSERT (42,3,"2007","Peugeot","65.808");
CALL CAR_INSERT (43,5,"2005","Audi","77.450");
CALL CAR_INSERT (44,2,"2016","Hyundai Motors","52.857");
CALL CAR_INSERT (45,5,"1993","Buick","88.317");
CALL CAR_INSERT (46,2,"1987","Mazda","57.703");
CALL CAR_INSERT (47,2,"2015","FAW","89.394");
CALL CAR_INSERT (48,3,"2004","Suzuki","27.036");
CALL CAR_INSERT (49,4,"2001","Dacia","90.950");
CALL CAR_INSERT (50,5,"2008","Dongfeng Motor","7.002");
CALL CAR_INSERT (51,2,"2010","Chevrolet","15.146");
CALL CAR_INSERT (52,1,"1993","Dodge","97.643");
CALL CAR_INSERT (53,2,"2013","Lexus","70.419");
CALL CAR_INSERT (54,4,"1989","Citroën","71.391");
CALL CAR_INSERT (55,4,"2010","Daimler","72.067");
CALL CAR_INSERT (56,1,"2016","JLR","92.205");
CALL CAR_INSERT (57,3,"2015","Honda","55.786");
CALL CAR_INSERT (58,2,"2020","Kenworth","31.989");
CALL CAR_INSERT (59,1,"1988","Dongfeng Motor","71.903");
CALL CAR_INSERT (60,3,"2019","Infiniti","00.854");
CALL CAR_INSERT (61,3,"2009","Fiat","91.747");
CALL CAR_INSERT (62,2,"2004","FAW","06.384");
CALL CAR_INSERT (63,1,"2016","General Motors","88.660");
CALL CAR_INSERT (64,3,"1987","Dodge","33.659");
CALL CAR_INSERT (65,4,"1988","Volkswagen","98.974");
CALL CAR_INSERT (66,2,"2012","Hyundai Motors","53.226");
CALL CAR_INSERT (67,5,"1998","MINI","97.618");
CALL CAR_INSERT (68,2,"1996","Jeep","85.058");
CALL CAR_INSERT (69,4,"2021","MINI","51.080");
CALL CAR_INSERT (70,1,"1989","FAW","56.783");
CALL CAR_INSERT (71,5,"1995","Dacia","06.457");
CALL CAR_INSERT (72,5,"2011","Fiat","98.648");
CALL CAR_INSERT (73,4,"2017","Maruti Suzuki","72.938");
CALL CAR_INSERT (74,1,"2007","Infiniti","39.618");
CALL CAR_INSERT (75,3,"2021","Seat","71.374");
CALL CAR_INSERT (76,2,"2019","Honda","65.532");
CALL CAR_INSERT (77,1,"2005","Kia Motors","67.347");
CALL CAR_INSERT (78,1,"2013","Acura","19.438");
CALL CAR_INSERT (79,2,"1985","Kia Motors","61.945");
CALL CAR_INSERT (80,1,"1990","Lincoln","25.458");
CALL CAR_INSERT (81,5,"2003","Dodge","96.638");
CALL CAR_INSERT (82,2,"2011","Nissan","52.993");
CALL CAR_INSERT (83,2,"2018","Renault","95.948");
CALL CAR_INSERT (84,1,"1998","Ferrari","61.499");
CALL CAR_INSERT (85,3,"1998","Isuzu","72.762");
CALL CAR_INSERT (86,1,"2005","Dongfeng Motor","15.802");
CALL CAR_INSERT (87,3,"1997","Dacia","88.596");
CALL CAR_INSERT (88,3,"2004","Daimler","59.085");
CALL CAR_INSERT (89,1,"2009","MINI","32.232");
CALL CAR_INSERT (90,3,"2007","Isuzu","92.933");
CALL CAR_INSERT (91,4,"2016","Volkswagen","08.519");
CALL CAR_INSERT (92,5,"2005","FAW","03.591");
CALL CAR_INSERT (93,1,"2020","Audi","47.701");
CALL CAR_INSERT (94,3,"2004","Mahindra and Mahindra","72.360");
CALL CAR_INSERT (95,3,"2002","Seat","03.615");
CALL CAR_INSERT (96,1,"2015","Smart","20.246");
CALL CAR_INSERT (97,5,"2008","Honda","03.091");
CALL CAR_INSERT (98,1,"2000","Tata Motors","10.715");
CALL CAR_INSERT (99,4,"2021","FAW","50.879");

/* COLOR */

CALL COLOR_INSERT (1,"red",NULL);
CALL COLOR_INSERT (2,"green","indigo");
CALL COLOR_INSERT (3,"yellow","cyan");
CALL COLOR_INSERT (4,"yellow","violet");
CALL COLOR_INSERT (5,"blue","blue");
CALL COLOR_INSERT (6,"yellow","indigo");
CALL COLOR_INSERT (7,"yellow",NULL);
CALL COLOR_INSERT (8,"green",NULL);
CALL COLOR_INSERT (9,"blue","blue");
CALL COLOR_INSERT (10,"green",NULL);
CALL COLOR_INSERT (11,"red","indigo");
CALL COLOR_INSERT (12,"red",NULL);
CALL COLOR_INSERT (13,"yellow","blue");
CALL COLOR_INSERT (14,"orange","indigo");
CALL COLOR_INSERT (15,"red","blue");
CALL COLOR_INSERT (16,"yellow","indigo");
CALL COLOR_INSERT (17,"yellow","blue");
CALL COLOR_INSERT (18,"blue","blue");
CALL COLOR_INSERT (19,"green","violet");
CALL COLOR_INSERT (20,"red","blue");
CALL COLOR_INSERT (21,"green","indigo");
CALL COLOR_INSERT (22,"yellow","violet");
CALL COLOR_INSERT (23,"red",NULL);
CALL COLOR_INSERT (24,"orange",NULL);
CALL COLOR_INSERT (25,"yellow",NULL);
CALL COLOR_INSERT (26,"yellow","violet");
CALL COLOR_INSERT (27,"orange","cyan");
CALL COLOR_INSERT (28,"red","indigo");
CALL COLOR_INSERT (29,"blue","violet");
CALL COLOR_INSERT (30,"blue","indigo");
CALL COLOR_INSERT (31,"green","violet");
CALL COLOR_INSERT (32,"orange","indigo");
CALL COLOR_INSERT (33,"green","violet");
CALL COLOR_INSERT (34,"yellow","blue");
CALL COLOR_INSERT (35,"yellow",NULL);
CALL COLOR_INSERT (36,"blue",NULL);
CALL COLOR_INSERT (37,"yellow",NULL);
CALL COLOR_INSERT (38,"red","indigo");
CALL COLOR_INSERT (39,"red","cyan");
CALL COLOR_INSERT (40,"green","violet");
CALL COLOR_INSERT (41,"yellow","violet");
CALL COLOR_INSERT (42,"yellow","blue");
CALL COLOR_INSERT (43,"red",NULL);
CALL COLOR_INSERT (44,"orange","indigo");
CALL COLOR_INSERT (45,"orange",NULL);
CALL COLOR_INSERT (46,"orange","indigo");
CALL COLOR_INSERT (47,"orange","cyan");
CALL COLOR_INSERT (48,"orange","violet");
CALL COLOR_INSERT (49,"yellow","violet");
CALL COLOR_INSERT (50,"orange","blue");
CALL COLOR_INSERT (51,"yellow","blue");
CALL COLOR_INSERT (52,"yellow","cyan");
CALL COLOR_INSERT (53,"green","cyan");
CALL COLOR_INSERT (54,"yellow","cyan");
CALL COLOR_INSERT (55,"green","cyan");
CALL COLOR_INSERT (56,"green",NULL);
CALL COLOR_INSERT (57,"blue","cyan");
CALL COLOR_INSERT (58,"orange",NULL);
CALL COLOR_INSERT (59,"blue","violet");
CALL COLOR_INSERT (60,"blue","violet");
CALL COLOR_INSERT (61,"green","blue");
CALL COLOR_INSERT (62,"yellow","blue");
CALL COLOR_INSERT (63,"blue","cyan");
CALL COLOR_INSERT (64,"yellow","violet");
CALL COLOR_INSERT (65,"blue",NULL);
CALL COLOR_INSERT (66,"green","violet");
CALL COLOR_INSERT (67,"orange","violet");
CALL COLOR_INSERT (68,"green","indigo");
CALL COLOR_INSERT (69,"yellow","cyan");
CALL COLOR_INSERT (70,"orange",NULL);
CALL COLOR_INSERT (71,"orange","indigo");
CALL COLOR_INSERT (72,"yellow",NULL);
CALL COLOR_INSERT (73,"yellow","violet");
CALL COLOR_INSERT (74,"blue","cyan");
CALL COLOR_INSERT (75,"yellow",NULL);
CALL COLOR_INSERT (76,"green","cyan");
CALL COLOR_INSERT (77,"blue","indigo");
CALL COLOR_INSERT (78,"yellow","violet");
CALL COLOR_INSERT (79,"green","violet");
CALL COLOR_INSERT (80,"green","blue");
CALL COLOR_INSERT (81,"yellow","cyan");
CALL COLOR_INSERT (82,"yellow","cyan");
CALL COLOR_INSERT (83,"blue","indigo");
CALL COLOR_INSERT (84,"yellow","violet");
CALL COLOR_INSERT (85,"green","blue");
CALL COLOR_INSERT (86,"blue","indigo");
CALL COLOR_INSERT (87,"yellow",NULL);
CALL COLOR_INSERT (88,"red","blue");
CALL COLOR_INSERT (89,"yellow","violet");
CALL COLOR_INSERT (90,"orange",NULL);
CALL COLOR_INSERT (91,"yellow",NULL);
CALL COLOR_INSERT (92,"orange","cyan");
CALL COLOR_INSERT (93,"green",NULL);
CALL COLOR_INSERT (94,"green","blue");
CALL COLOR_INSERT (95,"blue","blue");
CALL COLOR_INSERT (96,"orange","blue");
CALL COLOR_INSERT (97,"green","indigo");
CALL COLOR_INSERT (98,"blue","cyan");
CALL COLOR_INSERT (99,"red","blue");


/* CALLING VIEW TOTAL_REPORT WILL LOOK LIKE THAT WAY

PS: CAR MODEL NAME GENERATOR IT'S NOT AVAILABLE, SO, IN THIS CASE IS ASSIGNED NUMBERS INSTEAD OF MODELS

+----------+-------------------------+---------------------------------------------------+-----------+-----------------------+------+-------+---------+--------+----------+--------------+--------------+
| IDCLIENT | NAME                    | EMAIL                                             | SSN       | BRAND                 | YEAR | MODEL | MILEAGE | TINT   | PLUS     | PHONE        | TYPE         |
+----------+-------------------------+---------------------------------------------------+-----------+-----------------------+------+-------+---------+--------+----------+--------------+--------------+
|        1 | Ulysses R. Mccray       | lectus@eutellus.org                               | 016905796 | Smart                 | 2010 | 1     |      89 | red    | NOT HAVE | NOT INFORMED | NOT INFORMED |
|        2 | Anjolie K. Sweeney      | feugiat.placerat.velit@egestas.edu                | 275555597 | JLR                   | 1997 | 5     |       2 | green  | indigo   | 5716041034   | RES          |
|        3 | Simon F. Taylor         | vel.quam@nulla.net                                | 923072664 | Subaru                | 2010 | 4     |      95 | yellow | cyan     | NOT INFORMED | NOT INFORMED |
|        4 | Quyn L. Conway          | torquent@aliquameuaccumsan.com                    | 133618504 | General Motors        | 2003 | 5     |      20 | yellow | violet   | 1804600313   | RES          |
|        5 | Amy X. Gibson           | amet@tortorat.ca                                  | 492512611 | Tata Motors           | 2002 | 4     |      14 | blue   | blue     | NOT INFORMED | NOT INFORMED |
|        6 | Fulton L. Pierce        | magna.tellus@elitpharetra.co.uk                   | 627282882 | Lexus                 | 2001 | 4     |      54 | yellow | indigo   | 9005103691   | RES          |
|        7 | Nathaniel E. Burris     | auctor@nislsem.com                                | 050585769 | Acura                 | 2013 | 5     |      90 | yellow | NOT HAVE | NOT INFORMED | NOT INFORMED |
|        8 | Savannah J. Stein       | Ut.tincidunt@liberomaurisaliquam.com              | 622330116 | Audi                  | 2005 | 1     |      70 | green  | NOT HAVE | 7987386441   | TEL          |
|        9 | Jordan L. Koch          | sem.ut@mi.edu                                     | 031354848 | Mahindra and Mahindra | 2021 | 5     |      32 | blue   | blue     | NOT INFORMED | NOT INFORMED |
|       10 | Jordan U. Mason         | Sed@estacfacilisis.edu                            | 936706282 | Citroën               | 2016 | 3     |      57 | green  | NOT HAVE | 7274914717   | COM          |
|       11 | Barrett S. Hoover       | neque@massa.co.uk                                 | 129193413 | Toyota                | 1987 | 2     |      63 | red    | indigo   | NOT INFORMED | NOT INFORMED |
|       12 | Quin B. Hyde            | Fusce@mieleifendegestas.com                       | 028752855 | Lexus                 | 1987 | 1     |      56 | red    | NOT HAVE | 4559131992   | COM          |
|       13 | Natalie Z. Cruz         | quis.diam.luctus@vehicula.com                     | 658695762 | Mahindra and Mahindra | 2022 | 3     |      41 | yellow | blue     | NOT INFORMED | NOT INFORMED |
|       14 | Hanna W. Hansen         | Proin@acmattisornare.edu                          | 876709866 | MINI                  | 1991 | 5     |      56 | orange | indigo   | 2757906973   | TEL          |
|       15 | Tad C. Kirby            | accumsan.convallis@Proin.org                      | 108600586 | General Motors        | 2020 | 4     |      63 | red    | blue     | NOT INFORMED | NOT INFORMED |
|       16 | Catherine B. Knapp      | aliquet.Phasellus@VivamusnisiMauris.org           | 256356080 | Lincoln               | 1998 | 4     |      59 | yellow | indigo   | 9867854326   | COM          |
|       17 | Herman W. Morrow        | facilisi@ultriciessem.com                         | 043524917 | Ford                  | 2010 | 3     |      12 | yellow | blue     | NOT INFORMED | NOT INFORMED |
|       18 | Phelan B. Olsen         | sociis@ametrisus.org                              | 263292187 | Audi                  | 1998 | 1     |      48 | blue   | blue     | 7371293687   | COM          |
|       19 | Tanisha O. Smith        | turpis@Fuscealiquam.org                           | 238880306 | Volkswagen            | 2009 | 2     |      57 | green  | violet   | NOT INFORMED | NOT INFORMED |
|       20 | Kyle N. Ortega          | Fusce.dolor.quam@litoratorquent.net               | 413799115 | Ford                  | 2017 | 5     |      92 | red    | blue     | 1795580799   | RES          |
|       21 | Melodie U. Knight       | lacus.Mauris.non@maurissit.org                    | 607923539 | Lexus                 | 1989 | 5     |      98 | green  | indigo   | NOT INFORMED | NOT INFORMED |
|       22 | Axel Z. Terrell         | aliquam.enim.nec@Crasvehiculaaliquet.com          | 832525315 | FAW                   | 2014 | 2     |      56 | yellow | violet   | 5848391861   | COM          |
|       23 | Mannix V. Austin        | justo@eros.co.uk                                  | 190590620 | RAM Trucks            | 2001 | 4     |      72 | red    | NOT HAVE | NOT INFORMED | NOT INFORMED |
|       24 | Hop M. Mcclain          | lorem.tristique.aliquet@mattisvelitjusto.net      | 864354626 | Nissan                | 1988 | 1     |      18 | orange | NOT HAVE | 8103575357   | COM          |
|       25 | Kirestin U. Leach       | Curabitur@nisl.ca                                 | 237975552 | Suzuki                | 1999 | 5     |       1 | yellow | NOT HAVE | NOT INFORMED | NOT INFORMED |
|       26 | Riley J. Greer          | amet.diam@anunc.co.uk                             | 139769640 | Infiniti              | 2003 | 1     |      35 | yellow | violet   | 2658594036   | RES          |
|       27 | Jenette U. Lynch        | commodo.tincidunt.nibh@sitamet.net                | 006040224 | Isuzu                 | 1991 | 5     |      30 | orange | cyan     | NOT INFORMED | NOT INFORMED |
|       28 | Travis B. Tucker        | ac@vulputateposuerevulputate.ca                   | 455241885 | RAM Trucks            | 1994 | 3     |      91 | red    | indigo   | 6882472756   | COM          |
|       29 | Quamar O. Chen          | senectus.et@imperdiet.edu                         | 658278718 | RAM Trucks            | 2003 | 4     |      71 | blue   | violet   | NOT INFORMED | NOT INFORMED |
|       30 | Lacy F. Buck            | leo.Morbi@sit.co.uk                               | 631944386 | Mahindra and Mahindra | 2000 | 5     |      65 | blue   | indigo   | 5438270812   | COM          |
|       31 | Fatima H. Hahn          | nunc.id@magnaPhasellusdolor.com                   | 906380860 | Toyota                | 1998 | 1     |      12 | green  | violet   | NOT INFORMED | NOT INFORMED |
|       32 | Iliana L. Levine        | vel.arcu.eu@faucibus.net                          | 744131194 | Mercedes-Benz         | 2002 | 1     |      79 | orange | indigo   | 7629363612   | TEL          |
|       33 | Duncan K. Workman       | lacus@nasceturridiculusmus.com                    | 453846933 | FAW                   | 1995 | 3     |      11 | green  | violet   | NOT INFORMED | NOT INFORMED |
*/
