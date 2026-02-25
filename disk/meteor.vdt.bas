REM "----------------------------------------------"
OUTPUT bottom$
AT 24,10;REP$ 10,"<";REP$ 10,">"

REM "----------------------------------------------"
OUTPUT menu$
FAST
LINE0;CLEOL
CLS;"\n";PAPER 1;" ";CLEOL;bottom$
AT 2,13;SIZE 1;"<<< METEOR >>>"
?AT 4,1;"1.";UNDERLINE 1;" Jouer";UNDERLINE 0;" "
?"2. Records"
?"3. Configuration"
?"4. Crédits"
?"5. Quitter"
? CURSOR 1

REM "----------------------------------------------"
OUTPUT jeu$
AT 0,5;CLEOL;"SCORE: 000000   RECORD: 000000";CLS

REM "----------------------------------------------"
OUTPUT records$
LINE0;CLEOL;
CLS;"\n";PAPER 1;" ";CLEOL;bottom$
AT 2,13;SIZE 1;"<<< RECORDS >>>"
AT 4,1;"<Appuie sur une touche>"

REM "----------------------------------------------"
OUTPUT config$
LINE0;CLEOL
CLS;"\n";PAPER 1;" ";CLEOL;bottom$
AT 2,10;SIZE 1;"<<< CONFIGURATION >>>"
AT 4,1;"<Appuie sur une touche>"

REM "----------------------------------------------"
OUTPUT credits$
LINE0;CLEOL
CLS;"\n";PAPER 1;" ";CLEOL;bottom$
AT 2,13;SIZE 1;"<<< CREDITS >>>"
?AT 5,20-6;SIZE 3;INVERSE 1;"BASTOS"
?AT 7,2;"Inspiré par :"
?" - Sinclair ZX81 / Spectrum"
?" - Oric 1 / Atmos"
?" - Amstrad CPC"
?
?AT 14,20-6;SIZE 3;FLASH 1;"METEOR";
?AT 16,1;" Inspiré par";UNDERLINE 1;" METEOR";UNDERLINE 0;" : Premier jeu en"
?" assembleur Z80 sur ZX81. Sur Minitel,"
?" pas de mémoire écran, juste une prise"
?" 4800(M1B)/9600(M2) bps."

REM "----------------------------------------------"
OUTPUT STOP
SAVE"meteor.vdt.var"
RUN"meteor"
