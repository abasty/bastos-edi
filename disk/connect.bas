REM "Choix Wi-Fi"
100 GOSUB 3000

REM "Choix service"
110 b=0
120 nc=0
130 suiv=0
140 GOSUB 1000
150 AT 24,1;"Choix : .\x08";CURSOR 1
160 INPUT c$
170 k=VKEY
180 IF k=6 THEN 110
190 IF k<>4 THEN 230
200 IF suiv=0 THEN 150
210 b=b+5
220 GOTO 140
230 c=CODE c$-48
240 IF c<=0 OR c>nc THEN 150
250 GOSUB 2000+(b+c-1)*10
260 IF urn$="" THEN 150
270 PRINT AT 0,1;"Connecting to ";srv$
280 MINITEL urn$
290 GOTO 110

REM "Affiche page services"
1000 CURSOR 0;LINE0 ;CLEOL ;CLS ;SCROLL 0;"LISTE DES SERVICES\r\n";INK 4;REP$ 40,"`"
1010 FOR i=1 TO 4
1020 AT i*4+2,5;INK 4;REP$ 36,"`";"\n"
1030 NEXT i
1040 PRINT "\n\n";REP$ 40,"`";
1050 nc=0
1060 FOR i=1 TO 5
1070 GOSUB 2000+(b+i-1)*10
1080 IF srv$="" THEN 1130
1090 AT i*4-1,3;i;" ";srv$(1 TO 36)
1100 AT i*4,5;INK 6;desc$(1 TO 36)
1110 AT i*4+1,5;INK 2;urn$(1 TO 36)
1120 nc=nc+1
1130 NEXT i
1140 GOSUB 2000+(b+5)*10
1150 suiv=0
1160 IF srv$="" THEN 1190
1170 suiv=1
1180 AT 23,17;INK 2;"page suivante \x19\x2e";UNDERLINE 1; " ";INK 6;INVERSE 1;" SUITE  "
1190 AT 24,17;INK 2;"première page \x19\x2e ";INK 6;INVERSE 1;"SOMMAIRE"
1200 RETURN

REM "Services"
2000 srv$="minipavi"
2001 urn$="tcp:go.minipavi.fr:516"
2002 desc$="Kiosque Minipavi de ludojoey"
2009 RETURN
2010 srv$="3611"
2011 urn$="ws:3611.re:80:/ws"
2012 desc$="Annuaire électronique de cquest"
2019 RETURN
2020 srv$="3615"
2021 urn$="ws:3615co.de:80:/ws"
2022 desc$="Kiosque 3615 de cquest"
2029 RETURN
2030 srv$="hacker"
2031 urn$="ws:mntl.joher.com:2018:/?echo"
2032 desc$="Pour geeks rétro, de Polo"
2039 RETURN
2040 srv$="retrocampus"
2041 urn$="tcp:bbs.retrocampus.com:1651"
2042 desc$="Passerelle BBS de l'Italie"
2049 RETURN
2050 srv$="galaxy"
2051 urn$="ws:galaxy.microtel.fr:50124"
2052 desc$="Messagerie graphique de Sherlock"
2059 RETURN
2060 srv$="zboub"
2061 urn$="tcp:abasty-retro.fr:1967"
2062 desc$="Portage serveur monovoie 90's"
2069 RETURN
2990 srv$=""
2991 urn$=""
2992 desc$=""
2998 RETURN

REM "Choix Wi-Fi"
3000 OUTPUT ws$
3010 WIFI STATUS
3020 OUTPUT STOP
3030 ws=INDEX ws$,"Not connected"
3040 IF ws=0 THEN RETURN
3050 CLS
3060 WIFI SCAN
3070 INPUT "N° du réseau Wi-Fi : .\x08",wn
3080 IF wn<1 OR wn>10 THEN 3050
3090 IF ssid$(wn, 1)=" " THEN 3050
3100 WIFI wn
3110 GOTO 3000
