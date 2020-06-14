libname s 'C:\Users\wningyua\Desktop\ED_data\2016-2017';
options nofmterr;

data s.dat(DROP = VAR1);
set s.alcsud; /* original data is sud */

/** ETHUN **/
IF ETHUN=-9 THEN ETHUN=.;

/** RACEUN **/
IF RACEUN=-9 THEN RACEUN=.;

/** ETHRAC **/
ETHRAC=.;
IF ETHUN=1 THEN ETHRAC=4; /**HISPANIC**/
IF RACEUN=3 THEN ETHRAC=5;/**ASIAN**/
IF RACEUN=4 OR RACEUN=5 THEN ETHRAC=6; /**OTHER**/
IF ETHUN=1 AND RACEUN=1 THEN ETHRAC=1; /**WHITE-HIS**/
IF ETHUN=2 AND RACEUN=1 THEN ETHRAC=0;/**WHITE-NON**/
IF ETHUN=1 AND RACEUN=2 THEN ETHRAC=3; /**BLACK-HIS**/
IF ETHUN=2 AND RACEUN=2 THEN ETHRAC=2; /**BLACK-NONHIS**/

/** PAIN **/
IF PAIN=-8 or PAIN=-9 THEN PAIN=.;

/** RESIDNCE **/
IF RESIDNCE=-9 OR RESIDNCE=-8 THEN RESIDNCE=.;

/** ICU **/
IF ADMIT=1 THEN ICU=1; else ICU=0;

/** SEX **/
SEX=SEX-1; /* 0-F, 1-M*/

/**PAYTYPER**/
IF PAYTYPER=-9 OR PAYTYPER=-8 THEN PAYTYPER=.;
IF PAYTYPER=4 THEN PAYTYPER=7;
IF PAYTYPER=6 THEN PAYTYPER=5;

/**TEMPF1 (REPLACE TEMPF1) **/
IF TEMPF=-9 THEN TEMPF=.;
TEMPF=(TEMPF/10-32)/1.8;
IF 0<TEMPF<=36 THEN TEMPF1=1;
IF 36<TEMPF<=38 THEN TEMPF1=0;
IF TEMPF>38 THEN TEMPF1=2;

/**PULSE1 (REPLACE PULSE**/
IF PULSE=-9 OR PULSE=998  THEN PULSE=.;
IF pulse<=90 THEN PULSE1=0;
IF 90<pulse<=100 THEN PULSE1=1;
IF 100<pulse<=110 THEN PULSE1=2;
IF 110<pulse<=120 THEN PULSE1=3;
IF 120<pulse THEN PULSE1=4;


/**BPSYS:SBP**/
IF BPSYS=-9 THEN BPSYS=.;
IF BPSYS>120  THEN BPSYS1=2;
IF 80<=BPSYS<=120 THEN BPSYS1=0;
IF BPSYS<80 THEN BPSYS1=1;

/**BPDIAS:DBP**/
IF BPDIAS=-9 OR BPDIAS=998 THEN  BPDIAS=. ;
IF  BPDIAS <60 THEN  BPDIAS1 =1;
IF 60<= BPDIAS <=80 THEN  BPDIAS1 =0 ;
IF BPDIAS >80 THEN  BPDIAS1 =2;

/**SEEN72**/
IF SEEN72=-8 OR SEEN72=-9 OR SEEN72=0 OR SEEN72=3 THEN SEEN72=.;


/**IMMEDR**/
IF IMMEDR=-9 OR IMMEDR=-8 OR IMMEDR=0 OR IMMEDR=6 OR IMMEDR=7  THEN IMMEDR=.;

/**ARREMS**/
IF ARREMS=-8 OR ARREMS=-9 THEN ARREMS=.;
IF ARREMS=2 THEN ARREMS=0;


/**WAITTIME**/
if WAITTIME<0 or WAITTIME=9999 then WAITTIME=. ;


/**mbrfv1 (REPLACE RFV1) **/
brfv=RFV1/10;
if	1001	<=	brfv	<=	1099	then	brfv1=	1	;
if	1100	<=	brfv	<=	1199	then	brfv1=	2	;
if	1200	<=	brfv	<=	1259	then	brfv1=	3	;
if	1260	<=	brfv	<=	1299	then	brfv1=	4	;
if	1300	<=	brfv	<=	1399	then	brfv1=	5	;
if	1400	<=	brfv	<=	1499	then	brfv1=	6	;
if	1500	<=	brfv	<=	1639	then	brfv1=	7	;
if	1640	<=	brfv	<=	1829	then	brfv1=	8	;
if	1830	<=	brfv	<=	1899	then	brfv1=	9	;
if	1900	<=	brfv	<=	1999	then	brfv1=	10	;
									
if	2001	<=	brfv	<=	2099	then	brfv1=	11	;
if	2100	<=	brfv	<=	2199	then	brfv1=	12	;
if	2200	<=	brfv	<=	2249	then	brfv1=	13	;
if	2250	<=	brfv	<=	2299	then	brfv1=	14	;
if	2300	<=	brfv	<=	2349	then	brfv1=	15	;
if	2350	<=	brfv	<=	2399	then	brfv1=	16	;
if	2400	<=	brfv	<=	2449	then	brfv1=	17	;
if	2450	<=	brfv	<=	2499	then	brfv1=	18	;
if	2500	<=	brfv	<=	2599	then	brfv1=	19	;
if	2600	<=	brfv	<=	2649	then	brfv1=	20	;
if	2650	<=	brfv	<=	2699	then	brfv1=	21	;
if	2700	<=	brfv	<=	2799	then	brfv1=	22	;
if	2800	<=	brfv	<=	2899	then	brfv1=	23	;
if	2900	<=	brfv	<=	2949	then	brfv1=	24	;
if	2950	<=	brfv	<=	2979	then	brfv1=	25	;
if	2980	<=	brfv	<=	2999	then	brfv1=	26	;
									
if	3100	<=	brfv	<=	3199	then	brfv1=	27	;
if	3200	<=	brfv	<=	3299	then	brfv1=	28	;
if	3300	<=	brfv	<=	3399	then	brfv1=	29	;
if	3400	<=	brfv	<=	3499	then	brfv1=	30	;
if	3500	<=	brfv	<=	3599	then	brfv1=	31	;
									
if	4100	<=	brfv	<=	4199	then	brfv1=	32	;
if	4200	<=	brfv	<=	4299	then	brfv1=	33	;
if	4400	<=	brfv	<=	4499	then	brfv1=	34	;
if	4500	<=	brfv	<=	4599	then	brfv1=	35	;
if	4600	<=	brfv	<=	4699	then	brfv1=	36	;
if	4700	<=	brfv	<=	4799	then	brfv1=	37	;
if	4800	<=	brfv	<=	4899	then	brfv1=	38	;
									
if	5001	<=	brfv	<=	5799	then	brfv1=	39	;
if	5800	<=	brfv	<=	5899	then	brfv1=	40	;
if	5900	<=	brfv	<=	5999	then	brfv1=	41	;
if	6100	<=	brfv	<=	6700	then	brfv1=	42	;
if	7100	<=	brfv	<=	7140	then	brfv1=	43	;
if	8990	<=	brfv	<=	8999	then	brfv1=	44	;

mbrfv1=brfv1;
if	brfv1=	11	then	mbrfv1=	1	;
if	brfv1=	12	then	mbrfv1=	1	;
if	brfv1=	13	then	mbrfv1=	1	;
if	brfv1=	14	then	mbrfv1=	1	;
if	brfv1=	15	then	mbrfv1=	2	;
if	brfv1=	16	then	mbrfv1=	3	;
if	brfv1=	17	then	mbrfv1=	5	;
if	brfv1=	18	then	mbrfv1=	5	;
if	brfv1=	19	then	mbrfv1=	4	;
if	brfv1=	20	then	mbrfv1=	6	;
if	brfv1=	21	then	mbrfv1=	7	;
if	brfv1=	22	then	mbrfv1=	8	;
if	brfv1=	23	then	mbrfv1=	9	;
if	brfv1=	24	then	mbrfv1=	10	;
if	brfv1=	25	then	mbrfv1=	1	;
if	brfv1=	26	then	mbrfv1=	1	;
						
if	brfv1=	27	then	mbrfv1=	1	;
if	brfv1=	28	then	mbrfv1=	1	;
if	brfv1=	29	then	mbrfv1=	1	;
if	brfv1=	30	then	mbrfv1=	1	;
if	brfv1=	31	then	mbrfv1=	1	;
						
if	brfv1=	32	then	mbrfv1=	1	;
if	brfv1=	33	then	mbrfv1=	1	;
if	brfv1=	34	then	mbrfv1=	1	;
if	brfv1=	35	then	mbrfv1=	1	;
if	brfv1=	36	then	mbrfv1=	1	;
if	brfv1=	37	then	mbrfv1=	1	;
if	brfv1=	38	then	mbrfv1=	1	;
						
if	brfv1=	39	then	mbrfv1=	11	;
if	brfv1=	40	then	mbrfv1=	11	;
if	brfv1=	41	then	mbrfv1=	11	;
if	brfv1=	42	then	mbrfv1=	11	;
if	brfv1=	43	then	mbrfv1=	11	;
if	brfv1=	44	then	mbrfv1=	11	;


/**INJURY1**/
INJURY1 = INJURY;
IF INJURY=1 THEN INJURY1=1; ELSE INJURY1=0;
RUN;


/** dataset for <=18 **/
data s.dat_ped;
set s.dat;
if age<=18;
run;

/** dataset for >18 **/
data s.dat_adult;
set s.dat;
if age>18;
if age<40 then agegroup=0;
if 40=<age<50 then agegroup=1;
if 50=<age<60 then agegroup=2;
if 60<=age<75 then agegroup=3;
if 75<=age then agegroup=4;
run;



/** check the data*/
/** 
proc freq data=s.dat_adult;
table SUD;
weight PATWT ;
run;


proc freq data=s.dat_ped;
table SUD*age;
run;

proc contents data=s.dat;
**/
