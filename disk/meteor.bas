100 LOAD "meteor.vdt.var"
110 rc$="00000"
120 vn$="H"+(INVERSE 1)+"O"+(INVERSE 0)+"H"
130 vi$="/T\\"

140 PRINT menu$;
170 INPUT "Choix: ",c
180 c=INT c

190 IF c<1 THEN LET c=1
200 IF c>=5 THEN LET c=5
210 GOSUB c*100+200
220 GOTO 140

300 PRINT jeu$;CURSOR 0;
310 GOTO 900

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

REM "Jeu init"
REM "sc$: score, sx: X vaisseau, b: Compteur 1/10s"
REM "scr$: Screen / collision, top: n° 1ère ligne"
REM "col: à 1 si collision, l24: ligne 24 dans scr$"
REM "v: Vies"
900 sc$="00000"
902 sx=20
904 l24=23
906 DIM scr$(24,40)
908 DIM sm$(4,4)
910 FOR i=1 TO 24
912 scr$(i)=""
914 NEXT i
916 b=0
918 top=0
920 col=0
922 v=3
924 AT 0,28;"vies:";REP$ v,"°"
926 v$=vn$
928 immu=0

REM "Jeu boucle"
REM "---- Scroll down et ajuste top, l24 et scr$"
1000 SCROLL DOWN
1010 l24=(l24+23)%24
1020 top=(top+23)%24
REM "---- Test de collision"
1030 IF immu>0 THEN LET immu=immu-1
1040 IF immu>0 THEN 1110
1050 col=scr$(l24+1,sx,sx+2)<>"   "
1060 IF col=0 THEN 1110
REM "---- COLLISION"
1070 GOSUB 4200
1080 col=0
1090 PAUSE 500
1100 scr$(l24+1,sx,sx+2)="   "
REM "---- Affiche vaisseau"
1110 GOSUB 2500
REM "---- Star field"
1120 GOSUB 2000
REM "---- Nouveau meteor"
1130 GOSUB 5000
REM "---- Score"
1140 GOSUB 4000
1150 AT 0,7;sc$
1160 IF sc$>rc$ THEN LET rc$=sc$
1170 AT 0,21;rc$;"\n"
1180 k$=INKEY$
1190 IF k$="a" AND sx>1 THEN LET sx=sx-1
1200 IF k$="e" AND sx<37 THEN LET sx=sx+1
REM "---- Efface tir si t=1"
1210 IF t=0 THEN 1240
1220 GOSUB 3500
1230 GOTO 1260
REM "---- Tir si espace"
1240 IF immu=0 AND k$=" " THEN GOSUB 3000
REM "---- Fin jeu si x"
1250 IF k$="x" THEN RETURN
1260 PAUSE 150
1270 GOTO 1000

REM "Nouvelle etoile"
2000 r=INT(RND*100)
2010 e$="."
2020 IF r>=35 THEN LET e$="+"²
2030 IF r>=55 THEN LET e$="*"
2040 IF r>=65 THEN LET e$="o"
2050 IF r>=75 THEN LET e$="'"
2060 ec=INT(RND*40)+1
2070 AT 1,ec;e$
2080 RETURN

REM "Affichage vaisseau"
2505 IF immu>0 THEN LET v$=vi$
2510 IF immu=0 THEN LET v$=vn$
2520 AT 24,sx;v$
2530 RETURN

REM "Tir"
REM "Chercher la ligne / case d'impact en remontant"
REM "Pour l'instant : ligne 1"
3000 sxl=sx+1
3020 AT 23,sxl
3030 FOR l=1 TO 11
3040 PRINT "|\x08\x0b\x0b";
3060 NEXT l
3065 PRINT "|";
3070 t=1
3080 RETURN
REM "Tir efface"
3500 lt=1
3510 AT 22,sxl
3520 FOR l=1 TO 10
3530 PRINT " \x08\x0b\x0b";
3540 NEXT l
3545 PRINT " ";
3550 t=0
3560 RETURN

REM "Calcule nouveau score"
4000 b=(b+1)%10
4010 IF b<>0 THEN RETURN
4020 i=5
4030 IF sc$(i)<"9" THEN 4070
4040 sc$(i)="0"
4050 i=i-1
4060 GOTO 4030
4070 sc$(i)=CHR$((CODE sc$(i))+1)
4080 RETURN

REM "Explosion vaisseau"
4200 p=150
4210 AT 24,sx;"***"
4220 PAUSE p
4230 AT 24,sx;"-*-"
4240 PAUSE p
4250 AT 24,sx;" - "
4260 PAUSE p
4270 AT 24,sx+1;"."
4280 PAUSE p
4290 AT 24,sx+1;" "
4300 IF v<=0 THEN 4320
4310 v=v-1
4320 immu=24
4330 AT 0,28;"vies:";REP$ v,"°";" "
4340 RETURN

REM "Affiche meteor"
REM "sm$: Sprite meteor, cml: Current meteor line"
REM "lm: largeur meteor, hm: hauteur meteor"
REM "cm: colonne meteor"
5000 IF cml<>0 THEN 5030
REM "---- cml==0: Calcule un nouveau meteor"
5010 GOSUB 5500
REM "---- cml==0: Colonne nouveau meteor"
5020 cm=INT(RND*(41-lm))+1
REM "---- Affiche la ligne courante du meteor"
5030 AT 1,cm;sm$(hm-cml)
REM "---- MAJ scr$ pour test collision"
5040 scr$(top+1)=""
5050 scr$(top+1,cm TO cm+lm-1)="XXXXX"
REM "---- Ligne suivante dans le sprite meteor"
5060 cml=(cml+1)%hm
5070 RETURN

REM "Calcule nouveau meteor"
5500 sm$(1)=G1+"xt"
5510 sm$(2)=G1+"+'"
5530 hm=2
5540 lm=2
5550 RETURN


9000 AT 0,37;"STOP\n"
9010 IF INKEY$="" THEN 9010
9020 RETURN
