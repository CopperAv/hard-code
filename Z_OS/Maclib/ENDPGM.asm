* * * * * * * * * * * * * * CALL BACK * * * * * * * * * * * * * * * * *         
* LAST COMMAND BLOCK, RC VALUE NEEDED TO SUCCES ENDING CODE           *         
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *         
          MACRO                                                       *         
          ENDPGM &RTRNCODE                                            *         
          LH     15,&RTRNCODE            SET RETURN CODE IN R15       *         
          L      13,4(,13)               RESTORE OLD SA ADDRESS       *         
          L      14,12(,13)              LOAD R14                     *         
          LM     0,12,20(13)             LOAD FROM R0 TO R12          *         
          BR     14                      GO TO CALLER                 *         
          MEND                                                        *         
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *         
