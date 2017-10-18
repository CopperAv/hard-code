* * * * * * * * * * * * * * SAVEAREA CODE * * * * * * * * * * * * * * *         
* SAVE:|SYS|PSA|NSA|R14|R15|R0|R1|R2|R3|R4|R5|R6|R7|R8|R9|R10|R11|R12|*         
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *         
          MACRO                                                       *         
&LABEL    BGNPGM &SAVEAREA,&AMODE,&RMODE                              *         
&LABEL    CSECT  ,                                                    *         
&LABEL    AMODE  &AMODE                                               *         
&LABEL    RMODE  &RMODE                                               *         
          STM    14,12,12(13)            SAVE AFTER CALL ADDRESS REGS *         
          BALR   12,0                                                 *         
          USING  *,12                    ESTABLISH ADDRESSABILITY     *         
          LR     11,13                   SAVE CALLBACK ADDRESS IN R11 *         
          LA     13,&SAVEAREA            LOAD ADDRESS OF STORAGE      *         
          ST     11,4(,13)               STORAGE PSA AFTER 1 WORD     *         
          ST     13,8(,11)               STORAGE NSA AFTER 2 WORD     *         
          MEND                                                        *         
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *         
