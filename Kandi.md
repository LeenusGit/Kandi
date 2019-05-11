---
lang: sv
title: Autonoma fordon, utmaningar och möjligheter
date: 2019
author:
- name: Linus Kvikant, 39174
  affiliation:
  - Kandidatavhandling i datateknik
  - 'Handledare: Johan Lilius och Marina Waldén'
  - Fakulteten för naturvetenskaper och teknik
  - Åbo Akademi
abstract:
    'Avhandlingen redogör för viktiga aspekter inom autonoma fordon för vägtrafik. Det ges en snabb historisk överblick och sedan går vi igenom olika nivåer av automation. Efter det går vi igenom hur man kan ge ett autonomt fordon så bra uppfattning av omgivningen som möjligt. Avhandlingen jämför sensorer som används och går igenom hur man kan sammanfoga datan som de samlar in (Kalman filter). Sedan går vi igenom lokalisering och kartläggning och hur autonoma fordon samtidigt kan utföra dem (SLAM). Till sist tar vi en titt på några etiska dilemman och hur de påverkar utvecklingen av autonoma fordon.
    \newline
    \newline
    Nyckelord: autonoma fordon, sensorfusion, SLAM, etiska dilemman'

documentclass: article
numbersections: true
pagestyle: headings
papersize: a4
sansfont: "Times New Roman"
fontsize: 12pt
linestretch: 1.5
margin-left: 4.5cm
margin-right: 2.5cm
margin-top: 2.5cm
margin-bottom: 2.5cm
urlcolor: blue
header-includes:
    - \pagenumbering{gobble}
    # - \usepackage{caption}
include-before:
- '`\pagenumbering{gobble}`{=latex}'
# - '`\newpage{}`{=latex}'
- '\setcounter{section}{0}'
include-after:
- \newpage{}
- \pagenumbering{arabic}
---

<!-- "Avhandlingen ger en överblick över de utmaningar som finns inom autonoma fordon och specifikt redogöra det tekniska utmaningarna samt de föreslagna lösningarna som behövs för att autonoma fordon skall kunna röra sig säkert i trafiken." -->

# Inledning

<!-- ```python
# Varför är ämnet värt att undersöka?
# Vad handlar ämnet om?
# Vad kommer inte att behandlas i avhandlingen? Varför?
``` -->

<!-- >*"Road traffic is a self-organizing, chaotic system that,
although it is fundamentally governed by rules, includes many situations for which
unambiguous rules cannot be determined." -Berthold Färber* -->

Autonoma fordon är term för att beskriva fordon som inte behöver styras av en mänsklig förare. För samma definition används också termer som självkörande fordon och förarlösa fordon. I den här avhandlingen kommer även förkortningen ADS (autonomous driving system) att användas för att referera till någon form av kombination av mjuk- och hårdvara som klarar av att autonomt köra ett fordon.

En övergång till autonom trafik skulle innebära nya möjligheter för samhället eftersom det ger förarna möjligheten att använda tiden i fordonet till någonting mera produktivt. Dessutom skulle autonoma fordon ge ett nytt alternativ för personer som idag av någon orsak inte kan, eller inte vill, köra fordon i trafiken.

Enligt WHO (World Health Organization) dör det 1,3 miljoner människor människor i trafiken varje år [@WHO2018]. År 2015 gjordes en annan undersökning av NHTSA (National Highway Traffic Safety Administration) där man utredde den kritiska orsaken för olika kollisioner från 2005 till 2007 I USA. Man undersökte ungefär två miljoner kollisioner och i 94 % fallen kom man fram till att det var ett mänskligt fel som ledde till kollisionen. Det här betyder inte att autonoma fordon skulle minska antalet trafikolyckor med 94 %, men om man lyckas utveckla autonoma fordon som inte gör mänskliga misstag skulle antalet dödsfall i trafiken definitivt minska.

<!-- För att ett fordon skall kunna köra autonomnt kräver det att fordonet klarar av alla uppgifter som idag krävs att mänskliga förare. För att ett system skall ersätta en människa krävs att fordonet kan:

1. Trafikreglerna och kan operera fordonet.
2. Navigera till resemålet.
3. Göra samma observationer som en människa, d.v.s. få en uppfattning av omgiviningen.
4. Tolka trafiken utifrån de observationer som gjorts.
5. Välja en säker hastighet och färdriktning på av de tolkningar som gjorts, för att ta sig resemålet. -->

# Historisk överblick

Drömmen om en bil som kör sig själv är inte ny. Den tyska författaren Werner Illing beskrev redan på 1930-talet i *Utopolis* en bil som inte behövde en förare och som hade en metallplatta med en karta där man kunde placera en pil til den önskade destinationen [@Kröger2016]. På 1970-talet hade man en vision om att fordonen skulle styras med en ledningstråd inne i vägen (guide-wire) som skulle styra fordonets riktning och hastighet. Man motiverade styrningen med att det skulle minska på dödsfallen i trafiken. Man kom sedan fram till att trafik nätverk med ledningstråd inte var genomförbart ur en ekonomisk och teknisk synvinkel. Istället började man fokusera på automation som inte krävde stora investeringar i ny infrastruktur [@Kröger2016].

Ernst Dickmanns från University of Munich anses vara en pionjär inom utvecklandet av autonoma fordon. Han lyckades utveckla ett system som kunde köra en modifierad Mercedes-Benz W140 S-Class från Munchen till Köpenhamn 1995. Det var det första fordonet som använde digitala processorer och kameror för att autonomt köra i trafiken. Fordonet kunde dock endast köra på motorvägar och sträckan från München till Odense uppgavs vara körd 95% autonomt [@Oagana2016;@Delcker2018]. Samtidigt lyckades Carnegie Mellon Universitys NavLab utveckla ett fordon som kunde köra delvist autonomt från Pittsburgh till San Diego. Liksom Dickmanns Mercedes kunde systemet styra fordonet på basis av bilder tagna av kameror som fanns på fordonet, men NavLabs fordon krävde att en människa hanterade accelerationen och bromsningen. År 1998 lyckades University of Parma i Italien köra en Lancia Thema 2000 km i Italien enbart med hjälp kamerabaserad datorsyn. De här projekten, bland andra, gjorde att man helt frångick tanken om att fordonen skulle styras med någon form av infrastruktur, utan istället satsade man på autonoma fordon som m.h.a. datorsyn kunde köra på samma vägar som man alltid kört på [@Kröger2016].

# Grader av automation

## SAE:s nivåer av automation

SAE International (tidigare Society of Automotive Engineers) är en organisation som gett ut en standard, SAE J3016, vilken definierar olika nivåer av autonomi för fordon. År 2016 NHTSA införde (United States National Highway Traffic safety Administration) denna standard för autonoma fordon [@Holstein2018]. Standarden definierar en skala av autonomi för vägfordon, från Level 0 för ingen automation till Level 5 för för full automation [@J3016;@J3016Website].

## De icke-autonoma nivåerna

Level 0, Level 1 och Level 2 är icke-autonoma nivåer, d.v.s människan har fullt ansvar över fordonet, även om förarens fötter inte behöver vara på pedalerna eller förarens händer på ratten. Den mänskliga föraren måste alltid ha möjlighet att styra, bromsa och accelerera för att upprätthålla en säker resa. Till Level 0 hör assisterande funktioner som är begränsade till varningar och momentana hjälpfunktioner, t.ex. ABS eller ett system som varnar för andra fordon i sidospegelns döda vinkel. Till Level 1 hör funktioner som assisterar föraren med styrning **eller** acceleration/bromsning. I [@J3016Website] ges som exempel adaptiva farthållare (ACC) eller avåkningsvarnare (LKA). Om fordonet har funktioner som assisterar med både styrning **och** acceleration/inbromsning klassas det som ett Level 2 fordon (se figur @fig:level2) [@J3016;@J3016Website].

![Ett fordon med både AAC och LKA klassas som ett Level 2 fordon. Bilden tagen från [@ImgLKA].](images/Level2_autonomy.jpg){#fig:level2}

## De autonoma nivåerna

Level 3, Level 4 och Level 5 är autonoma nivåer, det betyder att när ADS:n (automated driving system) är påkopplad är det systemet som är ansvarig för fordonet, även om någon skulle sitta i förarsätet. Level 3 betyder att fordonet kan köra sig själv men kräver att en mänsklig förare övervakar och att personen kan återuppta körandet när systemet anser att det är nödvändigt. Level 4 betyder att systemet inte behöver en mänsklig övervakare och systemet själv kan köra sig till ett säkert ställe när det uppstår situationer systemet inte klarar av. Ett exempel är en ADS som kan köra på motorvägar utan övervakning men kräver att mänsklig förare tar över då fordonet skall svänga bort. Ifall den mänskliga föraren inte tar övar skall en Level 4 ADS själv kunna köra till ett säkert ställe, för att vänta på att en människa tar över, t.e.x. närmaste bensinstation eller busshållplats. En Level 5 ADS är ett system som inte behöver be om hjälp av en mänsklig förare, utan klarar av att köra helt autonomt i alla förhållanden. En Level 4 eller Level 5 ADS behöver dessutom inte genast ge tillbaka kontrollen till en mänsklig förare ifall den avgör att det inte är ett säkert läge att göra så.[@J3016;@J3016Website]

## Nivån av automation idag

Idag finns det flera bilar som klassas som Level 2 fordon, d.v.s de är utrustade med både ACC och LKA. Level 3 fordon finns det däremot inte. Audi hade tidigare meddelat att deras nya A8 skulle lanseras 2019 med en Level 3 ADS för trafikstockningar (Traffic Jam Pilot), men Audi säger att det på grund av juridiska problem inte var möjligt [@Paukert2018]. Det mest kända autonoma systemet idag är Teslas Autopilot. Man skulle kunna argumentera för att Teslas ADS är är ett Level 3 system, men eftersom systemet inte själv klarar av att avgöra när en mänsklig förare behöver ingripa [@Heath2018], så täcker Autopilot endast kriterierna för Level 2 autonomi.

GM (General Motors) släppte 2018 sin SuperCruise ADS vilken marknadsfördes som ett "hands-off" system. SuperCruise kan endast aktiveras för specifika landsvägar som GM på förhand har bestämt. SuperCruise fyller inte heller kriterierna för Level 3 eftersom systemet kräver att föraren alltid har sin uppmärksamhet på vägen [@Roy2018].

## Diskussion kring steget från Level 2 till Level 3

Steget från Level 2 till Level 3 flyttar ansvaret från människan till det autonoma systemet, tills systemet vid t.e.x. nödfall kräver att människan skall ta över igen. Vem är det då egentligen som har ansvaret för fordonet? Hur lång är en rimlig tid för att en människa skall hinna reagera, analysera situationen och sedan göra ett beslut över vilken åtgärd som behöver göras?

<!-- # Nivån i framtiden

```python
# När förväntas man uppnå full automation?
# Tekniska utmaningar
# Vilka tekniska aspekter behöver utvecklas för att nå full automation?
``` -->

# Fordonets uppfattning av omgivningen

För att ett fordon skall kunna köra autonomt krävs att de, liksom människor, kan observera miljön det befinner sig i. Generellt inom robotiken används olika typer av kameror och sensorer för att få övergripande bild av omgivningen. De två mest använda sensorerna inom autonoma fordon är kamera och lidar. Förutom dem används också radar och ultraljudssensorer. För att nå full automation krävs det grovt taget att fordonet åtminstone kan göra likadana observationer som människor kan och att de kan göra dem i samma väderförhållanden.

## Kamera

Fördelar med att använda traditionella kameror i trafiken är att de är relativt billiga, de kan användas på långa avstånd och bilderna från kamerorna kan användas för igenkänning och segmentering (se figur @fig:kamera). Dessutom är trafiksystemet vi har idag specifikt designat för människans syn. Däremot är kameror inte bra på att avgöra avståndet till en viss punkt i bilden. Kameror måste dessutom regelbundet kalibreras och deras förmåga att ta bilder försämras också i dåliga väderförhållanden [@Bagloee2016].

![Exempel på hur man kan segmentera en kamerabild, tagen från [@kamera_img]](images/image_segmentation.png){#fig:kamera}

Det är värt att notera att Teslas fordon använder primärt kameror för att få en uppfattning av omgivningen. Teslas vd. Elon Musk sade i ett TED talk 2017: "När man löst datorsyn med kameror (eller med synförmåga) så är automation löst... Man kan definitivt vara övermänsklig med enbart kameror"[@Musk2017]. Christian Häne et. al. beskriver i [@Häne2017] ett sätt att få syn runt hela fordonet m.h.a. ett multikamera system med "fish-eye" linser.

## Lidar

![Visualisering av ett punktmoln som är baserat på data från lidar sensorer [@Waymo2016].](images/waymo_lidar.jpg){#fig:lidar}

Lidar är ett sammansatt ord av "light and radar", men används också som förkortning för "Light Detection and Ranging". Lidar är en sensor som skickar ljusimpulser, mer specifikt laserimpulser, mot omgivningen för att sedan analysera den reflekterade impulsen, på det sättas kan avståndet till objektet beräknas [@zhao2018]. I praktiken har man en snurrande spegel som sprider ut impulserna runt hela fordonet för att generera en sk. punktmoln, d.v.s. en samling av punkter som tillsammans utgör en 3D karta (se figur @fig:lidar). Lidar möjliggör ett bättre djupseende än en kamera och fungerar bättre än kamera i dåliga väderförhållanden som regn och mörker. Lidar är däremot inte lika bra på igenkänning jämfört med kamera, eftersom lidar inte kan urskilja färger i sin omgivning, t.ex. två objekt som är fast i varandra skulle se ut som ett objekt för en lidar. En annan nackdel med lidar är att sensorerna ännu är relativt dyra. Enligt Jianfeng Zhao et. al. använde Google år 2017 i sina autonoma fordon en Velodyne HDL-64E 3D lidar vars pris är ungefär 80 000 dollar. Sedan dess har Velodyne gjort low- och mid-end versioner till ett betydligt lägre pris [@TU-editor2018]. Den längsta räckvidden för lidar som Velodyne marknadsför är 300 meter för sin Alpha Puck (tidigare VLS-128) [@Alpha_Puck2019].

## Radar och ultraljud

Radar och ultraljud kommer att kort gås igenom eftersom de främst används som sekundära sensorer i autonoma fordon. De har styrkor som komplementerar lidar och kamera och därför är de ändå värda att nämna.

Radar en relativt gammal teknik, men används också inom autonoma fordon, främst för att mäta avståndet till fordonet framför. Radarteknik går ut på att skicka ut radiovågor för att sedan analysera de reflekterade vågorna. I förhållande till lidar har radar data inte lika bra upplösning (se figur @fig:radar), men radar har däremot generellt en längre räckvidd än lidar och kan dessutom se igenom terräng och dåligt väder. Lång distans radar kan nå en räckvidd på 300 meter.

![En jämförelse av upplösningen hos en lidar och radar [@Mark2017]. I radardatan kan man inte längre känna igen objekten i trafiken.](images/lidar_radar.png){#fig:radar}

Man kan också analysera reflekterade ljudvågor för att mäta avståndet till något objekt. Avståndet till något objekt räknas ut genom att skicka ut och ta emot ljudvågor med en frekvens som är för hög för att människor skulle kunna uppfatta dem. Ultraljudsensorer har en kort räckvidd och används i parkerinsgsensorer [@Bagloee2016].

# Sensorfusion

Människor är levande bevis på att två ögon kan ge tillräcklig med information för att kunna köra säkert i trafiken. Det betyder att ett autonomt fordon skulle kunna klara sig på enbart kameror, vilket antagligen är Teslas tankesätt med tanke på att de har valt att inte installera lidar i sina autonoma fordon. Problemet är att det antar att vi kan utveckla system som är lika bra som människor på att tolka bilder på omgivningen. För att få en så bra uppfattning av omgivningen som möjligt är det rimligt att sammanbinda informationen som ges av olika sensorer eller olika typer av sensorer. Den här typen av sammanbindning brukar kallas sensorfusion eller multisensor datafusion.

## Kalman filter

![Ett diagram som beskriver ett fordons position. Den blåa linjen enligt distansmätning, de röda prickarna är GPS sampel och den gröna linjen är den sammansatta uppskattningen med ett Kalman filter. Notera att fordonets verkliga position inte finns med. Hämtat från [@Kalman_img]](images/KalmanFusion.png){#fig:kalman}

Den mest kända och mest använda algoritmen för sensorfusion är Kalman filter [@Cohen2018], namnet kommer från att man vill filtrera bort brus från en sensor genom att ta en annan sensor i beaktande. Ett exempel som ges i [@Gover2014] av Francis Govers är ett fordon i trafiken som har både GPS och hastighetsmätare. Fordonet kör med konstant hastighet. Om fordonet regelbundet samplar sin position med GPS och fordonet samtidigt samplar sin hastighet, så kan man avgöra hur rimliga samplen från GPS:n är. I praktiken kan en GPS mottagare ge sampel som är flera meter från den verkliga positionen [@Bagloee2016], men eftersom vi vet att hastigheten är konstant kan vi räkna ut fordonets position enligt formeln $x = x_0 + vt$, där $x_0$ är fordonets position vid föregående sampel. Om positionen som GPS:n ger inte stämmer överens med formeln, så är det mera rimligt att lita på hastighetsmätaren än GPS mottagaren. En visualisering ges i figur @fig:kalman där man sammanfogar data från GPS och distansmätning (odometry) hos ett fordon.

# Lokalisering och Kartläggning

Två viktiga frågor inom robotiken (och därmed också inom autonoma fordon) är:

- Var tror roboten att den befinner sig?
- Var befinner sig den i egentligen?

Sensorer uppfångar alltid någon form av brus, vilket kan leda till att svaren på de här frågorna inte kommer att stämma överens. Lokalisering går ut på att man reder ut var man befinner sig i en på förhand känd omgivning. Kartläggning är det motsatta, man känner till sin position men omgivningen är okänd.

Idag används GPS för att lokalisera fordonet i trafiken men precisionen är inte tillräcklig för ett autonomt fordon. GPS kräver dessutom konstant signal till flera satelliter, vilket kan leda till att signalen försvinner i täta städer [@Bagloee2016], därför behövs en annan metod för att ett autonomt fordon skall kunna lokalisera sig själv.

Googles Waymo har använt lidar för att lokalisera sina fordon i trafiken. I praktiken har Waymo lidar skannat in alla vägar på förhand, så att deras autonoma fordon kan matcha sin position till den kartan [@Waymo2016]. Det kallas att använda en *a priori* karta. Ett problem som uppstår med den här metoden är att vägar regelbundet förändras. Enligt Waymo kan deras autonoma fordon hantera små förändringar som vägarbete eller stängda filer, men det är okänt hur bra deras fordon kan hantera stora förändringar i omgivningen [@Waymo2016].

## SLAM

Om ett autonomt fordon inte har en på förhand känd karta av omgivningen så måste fordonet samtidigt kartlägga sin omgivning och lokalisera sig i den omgivningen. Inom robotiken kallas det SLAM (simultaneous localization and mapping). Man brukar också använda termen "SLAM problemet" eftersom SLAM är ett höna eller ägg problem; man skall bygga en karta i förhållandet till sin position samtidigt som man skall reda ut sin position i förhållandet till kartan.

Det finns ändå algoritmer för att göra SLAM, de mest använda är EKF (Extended Kalman Filter), FastSLAM och Graph SLAM. I [@Takleh2018] har Takleh et. al. jämfört de här algoritmerna och kommit fram till att den mest använda algoritmen EKF inte är lämplig för autonoma fordon eftersom komplexiteten växer kvadratiskt då antalet landmärken växer. Takleh et. al. föreslår FastSLAM som det bästa alternativet för autonoma fordon. SLAM problemet är ändå en öppen fråga inom robotiken, enligt John Leonard, Professor på MIT och forskare inom navigation och kartläggning. Han sade i ett seminarium 2015 att snabbare effektivare lösningar på SLAM behövs för att utveckla Level 5 autonoma fordon [@Leonard2015]. Eftersom Teslas Autopilot inte använder en *a priori* lidar karta för att lokalisera sig behöver Tesla en genomförbar lösning på SLAM problemet.

<!-- # Kontext inom trafiken

```python
# Utmaningar gällande fordonets förmåga att fatta beslut.
# Hårda och flexibla regler.
# Hur kan fordonet "förstå" trafiken?
# Fordonets förmåga att göra mänskliga beslut.
``` -->

# Kommunikation mellan fordon

V2X är en term för att lätt referera till all kommunikation från ett visst fordon till ett annat system. Andra termer som ofta används är V2V (vehicle to Vehicle) för kommunikation mellan fordon och V2I (vehicle to infrastructure) för kommunikation mellan fordon och infrastruktur, t.e.x. trafikljus. V2D/V2P (vehicle to device/pedestrian) används för hänvisa till kommunikation mellan fordon och fotgängares smarttelefoner.

<!-- ```python
# Är V2X nödvändigt?
``` -->

## DSRC

USA:s Federal Communications Commission (FCC) reserverade 1999 en 75 MHz bandbredd vid 5,9 GHz för V2X kommunikation. DSRC (Dedicated short-range communications) är ett trådlös kommunikationsteknologi som baserar sig på IEEE 802.11p WIFI standarden. Standarden, även kallad Wave (1609 Wireless Access in Vehicular Environment), använder det givna intervallet. DSRC kommunikation kräver ingen extern server för att skicka data från ett fordon till ett annat. Signalerna skickas direkt från fordon till fordon vilket gör att latensen kan bli så låg som 10 millisekunder. I [@Liu2016] gjorde Liu et.al. 2016 en studie där man jämförde DSRC med LTE för V2X kommunikation. Deras resultat visade att förhållandet mellan de mottagna och skickade nätverkspaket med DSRC sjönk drastiskt då avståndet mellan fordonen blev längre än 100 meter.

<!-- ## LTE V2X

```python
# Hur fungerar V2X med mobilnät?
``` -->

# Etisk aspekt

Vissa olyckor är oundvikliga. Patrick Lin ger ett exempel i [@Lin2016]: ett fordon kör längs med en landsväg, mitt på vägen står en liten flicka och en gammal farmor. Fordonet hinner svänga till vänster för att endast köra på flickan eller till höger för att endast träffa farmorn, fordonet kör en sådan hastighet att personen som träffas av fordonet helt säkert dör. Om fordonet inte svänger kommer bägge två att bli under bilen.

En människa har i en sådan situation en mycket kort tid på sig att reagera, och kommer knappast att ställas till svars för valet som han eller hon gör, eftersom förarens beslut inte är ett kognitivt val, utan snarare en panikartad raktion. En mänsklig förare förväntas inte göra det mest etiska eller säkraste valet, eftersom vi inte har en tillräckligt snabb reaktionshastighet för att göra ett rationellt beslut. Däremot är autonoma fordon programmerade på förhand, av personer som har har både tid och möjlighet att bestämma hur fordonet skall agera utifrån den information som ges av sensorerna. Hur skall då en ADS programmeras för att hantera fordonet i situationen ovan? Det flesta människor skulle antagligen välja att rädda flickan eftersom hon är yngre och har en större del av sitt liv framför sig än farmorn. Patrick Lin skriver att det enligt IEEE (Institute of Electrical and Electronics Engineers) är ett fall av åldersdiskriminering, eftersom valet har gjorts enbart basis av ålder fastän det inte är relevant faktor, och därför är inte valet etiskt korrekt. Ett alternativ skulle vara att inte göra ett beslut alls, men att låta två personer dö för att undvika diskriminering verkar som det sämsta beslutet. Om man värdesätter mänskligt liv skulle det i så fall vara bättre att istället slumpmässigt välja ett offer. Enligt Lin finns det inget rätt svar på frågan, men han hävdar att det inte är helt etiskt korrekt att låta slumpen avgöra, när det ändå potentiellt finns relevanta aspekter man kan ta i beaktande för att göra ett val. Man kan förstås alltid undvika det etiska dilemmat genom att ge över kontrollen tillbaka till föraren, men för att nå full automation krävs ett bättre alternativ.

![Ett fordon måste välja att köra på en motorcyklist med hjälm eller en annan utan hjälm [@Motorcyclists].](images/motorcyclists_small.png){#fig:motorcycle}

Ett annat exempel Lin för fram är en likadan situation som i exemplet ovan, men istället för att välja mellan att köra över en flicka eller en farmor måste fordonet svänga för att kollidera med motorcyklist med hjälm eller kollidera med en motorcyklist utan hjälm (se figur @fig:motorcycle). För fordonet spelar det knappast någon roll vem av motorcyklisterna som kolliderar med bilen men för motorcyklisterna är det troligen en fråga om liv och död. Om man väljer att värdera mänskligt liv över allt annat skulle man programmera fordonet att träffa motorcyklisten med hjälm, eftersom den personen har större chans att överleva. Problemet är att fordonet då i princip bestraffar motorcyklisten som ansvarsfullt har valt att lägga hjälmen på. Om alla fordon skulle fungera på det här sättet skulle det antagligen var säkrare att köra motorcykel utan hjälm. Om fordonet istället skulle välja att kollidera med motorcyklisten utan hjälm så har det då aktivt valt att ta ett liv som kanske skulle ha gått att räddas. Det här exemplet visar att det inte är självklart att fordon skall värdera liv framöver allt annat.

Vad skall då fordonet värdera? En annan aktuell diskussion handlar om autonoma fordon skall prioritera den egna föraren eller utomstående personer i trafiken [@Bonnefon2016]. I en studie av Bonnefon et. al. frågades personer ifall de tycker att ett autonomt fordon borde offra föraren och/eller en passagerare för att rädda tio stycken fotgängare. Studien kom fram till att de flesta tyckte att fordonet borde handla utilitaristiskt d.v.s. rädda så många människor som möjligt. Deltagarna svarade ändå att de hellre skulle köpa ett fordon som räddar föraren och passageraren än ett fordon som istället räddar tio stycken fotgängare. Enligt Bonnefon et. al. kan det leda till att autonoma fordon som alltid handlar utilitaristiskt höjer konsumenternas tröskel att köpa autonoma fordon och på sätt blir övergången till autonoma fordon långsammare. Det skulle leda till att det dör flera personer i icke-autonom trafik än antalet man räddar med utilitaristiska autonoma fordon.

# Avslutning

Autonoma fordon för konsumenter har länge varit ett mål inom bilindustrin och utvecklingen av autonoma fordon har framskridit snabbt de senaste åren, men ändå är vi långt ifrån en Level 5 ADS. Vi har sett att fordonstillverkare är väldigt försiktiga med att kalla sina fordon Level 3 fordon eftersom det är en hög tröskel att kliva över. Ett stort potentiellt hinder inom autonoma fordon skulle vara en sk. "Hindenburg katastrof". Om man släpper ut ett autonomt fordon som skapar en stor olycka kan det leda till att allmänheten helt och hållet tappar förtoendet för autonoma fordon.

I den här avhandlingen har vi gått igenom hur man i dagens läge m.h.a. sensorer kan skapa en så bra uppfattning av omgivningen som möjligt och hur man kan lokalisera sig i den omgivningen. Det återstår ännu att undersöka hurdan sammansättning av sensorer som kommer att fungera bäst i längden. Kan man klara sig med kamerabaserad datorsyn eller måste man acceptera den extra kostnaden av att installera lidar?

I dagens läge har vi inga maskiner som har makten att avgöra i frågor om liv eller död. Vårt trafiksystem har klara regler, men det uppstår ibland situationer där det säkraste alternativet är att bryta mot någon regel. Dessutom är det sannolikt att framtidens autonoma fordon sannolikt kommer att hamna i någon variation av de etiska dilemman som tagits upp. Men den makt som autonoma fordon skulle ha över passagerarna och fotgängarna omkring är det mycket viktigt att tillverkarna gör det klart vad fordonet kommer att prioritera och hur det kommer att agera i etiskt krångliga situationer.

# Litteraturförteckning
