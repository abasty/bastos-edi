100 LOAD "meteor.vdt.var"
110 v$="H"+(INVERSE 1)+"O"+(INVERSE 0)+"H"
120 sc$="00000"
130 rc$=sc$

140 PRINT menu$;
170 INPUT "Choix: ",c
180 c=INT c

190 IF c<1 THEN LET c=1
200 IF c>=5 THEN LET c=5
210 GOSUB c*100+200
220 GOTO 140

300 PRINT jeu$;CURSOR 0;
310 GOTO 1000

400 PRINT records$;
410 IF INKEY$ ="" THEN 410
420 RETURN

500 PRINT config$;
510 IF INKEY$ ="" THEN 510
520 RETURN

600 PRINT credits$;
610 IF INKEY$ ="" THEN 610
620 RETURN

700 CLS
710 END


REM "jeu"
1000 sx=20
1010 b=0
1020 SCROLL DOWN
1030 b=(b+1)%10
REM "---- Score"
1040 GOSUB 6000
1050 AT 0,12;sc$
1060 IF sc$<rc$ THEN 1080
1070 AT 0,29;sc$
1080 PRINT "\n";
REM "---- Etoile star field"
1090 GOSUB 5000
1100 k$=INKEY$
1110 IF k$="a" AND sx>1 THEN LET sx=sx-1
1120 IF k$="e" AND sx<37 THEN LET sx=sx+1
1130 IF t=0 THEN 1160
REM "---- Efface tir"
1140 GOSUB 5600
1150 GOTO 1170
REM "---- Tir si espace"
1160 IF k$=" " THEN GOSUB 5500
REM "---- Affiche vaisseau"
1170 AT 24,sx;v$
REM "---- Fin jeu si x"
1180 IF k$="x" THEN RETURN
1190 PAUSE 100
1200 GOTO 1020

REM "Nouvelle etoile"
5000 r=INT(RND*100)
5010 e$="."
5020 IF r>=35 THEN LET e$="+"
5030 IF r>=55 THEN LET e$="*"
5040 IF r>=65 THEN LET e$="o"
5050 IF r>=75 THEN LET e$="'"
5060 ec=INT(RND*40)+1
5070 AT 1,ec;e$
5080 RETURN

REM "Tir"
REM "Chercher la ligne / case d'impact en remontant"
REM "Pour l'instant : ligne 1"
5500 lt=1
5510 sxl=sx+1
5520 AT 23,sxl
5530 FOR l=23 TO lt STEP -2
5540 PRINT "|\x08\x0b";
5550 IF l<>lt THEN PRINT "\x0b";
5560 NEXT l
5570 t=1
5580 RETURN

REM "Tir efface"
5600 AT 21,sxl
5610 FOR l=21 TO lt+1 STEP -2
5620 PRINT " \x08\x0b\x0b";
5630 NEXT l
5640 t=0
5650 RETURN

REM "Score"
6000 IF b<>0 THEN RETURN
6010 i=5
6020 IF sc$(i)<"9" THEN 6060
6030 sc$(i)="0"
6040 i=i-1
6050 GOTO 6020
6060 sc$(i)=CHR$ ((CODE sc$(i)) + 1)
6070 RETURN
