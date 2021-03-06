* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *         
* HLASM PROGRAMM: FIRSTASK                                            *         
*  1 GET ARGS FROM JCL                                                *         
*  2 PARS THEM TO 2 ARG                                               *         
*  3 SUBSTRING 1 ARG, USE SYMBOL'S IN 2 ARG                           *         
*  4 WRITE RESULT                                                     *         
*  5 RETURN RESULT OF EXECUTION                                       *         
*  5.1 RC = 0, IN JCL 2 ARGS                                          *         
*  5.2 RC = 4, IN JCL 1 ARG (OR LENGTH = 0)                           *         
*  5.3 RC = 8, IN JCL 0 ARG (OR LENGTH = 0)                           *         
* LINKAGE:                                                            *         
*     ===  INPUT:                                                     *         
*      R1: ARGUMENT FROM JCL                                          *         
*     R13: USING                                                      *         
*     R14: RETURN ADDRESS                                             *         
*     ===  OUTPUT:                                                    *         
*     R15: RETURN CODE                                                *         
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *         
          PRINT  NOGEN              NOT OPEN MACRO                    *         
          YREGS  ,                                                    *         
FIRSTASK  BGNPGM SAVEAREA,31,ANY    MACRO WITH CSECT AND LINKAGE      *         
          GETPARM LEN,STRING        SET PARM FROM R1(ADDRES)          *         
          LHI    R15,8              LOAD IN R15 8(HALFWORD)           *         
          STH    R15,RC             SAVE R15 AS RETURN CODE           *         
          LHI    R7,0               LOAD IN R7 0(HALFWORD)            *         
          CH     R7,LEN             IF (LEN == 0) THEN                *         
          BE     RTRN               >TO EXIT                          *         
          LHI    R15,4              LOAD IN R15 4(HALFWORD)           *         
          STH    R15,RC             SAVE R15 AS RETURN CODE           *         
          LH     R3,LEN             LOAD IN R3 LEN                    *         
          LA     R4,STRING          LOAD ADDRESS OF STRING IN R4      *         
          LA     R5,STR1            LOAD ADDRESS OF STR1 IN R5        *         
          LA     R6,COMMAPOS        LOAD ADDRESS OF COMMAPOS IN R6    *         
          STH    R7,COMMAPOS        SAVE R7 (0 (HALFWORD)) IN COMMAPOS*         
LP_PARS   EQU    *                                                    *         
          CLI    0(R4),C','         IF (R4 CHARACTER == ',') THEN     *         
          BNE    MOVE_CHR           >MOVE THIS CHAR IN STR_N (GO TO)  *         
          LA     R5,STR2            LOAD ADDRESS OF STR1 IN R5        *         
          LA     R4,1(R4)           LOAD ADDRESS OF R4 AS R4+1        *         
          STH    R3,COMMAPOS        SAVE R3 AS COMMAPOS               *         
          BCTR   R3,0               SUBSTRACT R3 ONCSE                *         
MOVE_CHR  EQU    *                                                    *         
          MVC    0(1,R5),0(R4)      MOVE 1 CHARACTER FORM R4 TO R5    *         
          LA     R4,1(R4)           LOAD ADDRESS OF R4 AS R4+1        *         
          LA     R5,1(R5)           LOAD ADDRESS OF R5 AS R5+1        *         
          BCT    R3,LP_PARS         IF (R3 != 0) ITER-- AND GOTO LOOP *         
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *         
* END PARSING LOOP                                                    *         
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *         
          CH     R7,COMMAPOS        IF (R7 (0 (HALFWORD)) == COMMAPOS)*         
          BE     RTRN               >TO EXIT                          *         
          LHI    R15,0              LOAD IN R5 0(HALFWORD)            *         
          STH    R15,RC             SAVE R15 AS RC                    *         
          LH     R3,LEN             LOAD IN R3 LEN (HALFWORD)         *         
          SH     R3,COMMAPOS        SUBSTRACT R3 BY COMMAPOS          *         
          LA     R4,STR1            LOAD ADDRESS OF STR1 IN R4        *         
          LA     R6,NEWSTR          LOAD ADDRESS OF NEWSTR IN R6      *         
LP_DEL_I  EQU    *                                                    *         
          LA     R5,STR2            LOAD ADDRESS OF STR2 IN R5        *         
          LH     R7,COMMAPOS        LOAD IN R3 COMMAPOS               *         
          BCTR   R7,0               SUBSTRACT R3 ONCSE                *         
LP_DEL_J  EQU    *                                                    *         
          MVC    CHAR1,0(R4)        M0VE 1 CHARACTER FROM R4          *         
          MVC    CHAR2,0(R5)        M0VE 1 CHARACTER FROM R5          *         
          CLC    CHAR1,CHAR2        IF (CHAR1 == CHAR2) THEN          *         
          BE     NEXT_CHR           >MOVE TO THE NEXT CHAR IN STR1    *         
          LA     R5,1(R5)           LOAD ADDRESS OF R5 AS R5+1        *         
          BCT    R7,LP_DEL_J        IF (R7 != 0) ITER-- AND GOTO LOOP *         
          MVC    0(1,R6),0(R4)      MOVE 1 CHARACTER TO R6 FROM R4    *         
          LA     R6,1(R6)           LOAD ADDRESS OF R6 AS R6+1        *         
NEXT_CHR  EQU    *                                                    *         
          LA     R4,1(R4)           LOAD ADDRESS OF R4 AS R4+1        *         
          BCT    R3,LP_DEL_I        IF (R3 != 0) ITER-- AND GOTO LOOP *         
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *         
* PRINT ANSWER                                                        *         
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *         
          WTO    TEXT=ANSW1         PRINT ANSW1                       *         
          WTO    TEXT=ANSW2         PRINT ANSW2                       *         
          WTO    TEXT=ANSW3         PRINT ANSW3                       *         
RTRN      EQU    *                                                    *         
          ENDPGM RC                 MACRO TO EXIT                     *         
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *         
SAVEAREA  DS     18F                SAVEAREA, WHERE SAVE YOUR REGS    *         
LEN       DS     H                  LEN OF PARM ARGUMENT FROM JCL     *         
STRING    DS     CL256              STRING FROM PARM FROM JCL         *         
RC        DS     H                  RETURN CODE                       *         
COMMAPOS  DS     H                  POSITION OF COMMA                 *         
ANSW1     EQU    *                  FIRST ANSWER                      *         
          DC     H'134'             SIZE                              *         
          DC     CL6'STR1: '        CONSTANT TEXT                     *         
STR1      DS     CL128              DYNAMIC STRING                    *         
ANSW2     EQU    *                  SECOND ANSWER                     *         
          DC     H'134'             SIZE                              *         
          DC     CL6'STR2 :'        CONSTANT TEXT                     *         
STR2      DS     CL128              DYNAMIC STRING                    *         
ANSW3     EQU    *                  RESULT OF OPERATION               *         
          DC     H'136'             SIZE                              *         
          DC     CL8'RESULT: '      CONSTANT TEXT                     *         
NEWSTR    DS     CL128              DYNAMIC STRING                    *         
CHAR1     DS     C                  1 BUFFER CHARACTER                *         
CHAR2     DS     C                  2 BUFFER CHARACTER                *         
          END    FIRSTASK           END OF PROGRAMM                   *         
