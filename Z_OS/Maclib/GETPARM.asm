* * * * * * * * * * * * LOAD ARGS FROM PARM * * * * * * * * * * * * * *         
* SET FROM R1 LEN OF STRING AND STRING V_1                            *         
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *         
          MACRO                                                       *         
          GETPARM &LEN,&STRING                                        *         
          L      2,0(,1)                                              *         
          MVC    LEN,0(2)                                             *         
          LH     3,LEN                                                *         
          BCTR   3,0                                                  *         
AGETMOVE  MVC    STRING(*-*),2(2)                                     *         
          EX     3,AGETMOVE                                           *         
          MEND                                                        *         
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *         
