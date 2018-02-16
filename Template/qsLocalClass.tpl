#Template(qsLocalClass,'Qualitas Solutions''s - Local Class'),FAMILY('ABC')
#!---------------------------------------------------------------------------------
#SYSTEM
  #EQUATE(%AppTPLFontName,'Tahoma')
#!
#!---------------------------------------------------------------------------------
#!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#!                                               APPLICATION EXTENSION
#!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#!
#EXTENSION(qsLocalClassGlobal,'Activate Qualitas Solutions''s Local Class Generator-Global'),APPLICATION
#SHEET
  #TAB('General')
    #INSERT  (%SETCC)
    #DISPLAY ('')
    #INSERT  (%SETAPP)
    #DISPLAY ('')
    #BOXED   ('Debugging'),section,AT(,95,,28),prop(PROP:FontName,%AppTPLFontName)
      #PROMPT  ('Disable All Qualitas Solutions''s Local Class Features',Check),%qsDisableLocalAll,AT(10,4),PROP(PROP:FontName,%AppTPLFontName)
    #ENDBOXED
  #ENDTAB
#ENDSHEET
#!
#!
#!
#!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#!                                Procedure Extension
#!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#EXTENSION(qsLocalClassProcedure,'Qualitas Solutions''s Local Class Generator-Procedure'),PROCEDURE,REQ(qsLocalClassGlobal),Multi
#SHEET
  #TAB('General')
    #BOXED('Local Class'),Section
      #ENABLE(%qsDisableLocalAll = %FALSE)
        #Prompt('Use Local Class',CHECK),%qsUseLocal,At(10,5)
        #ENABLE(%qsUseLocal = %TRUE)
          #PROMPT('Local Class Name:',@s200),%qsLocalClassName,DEFAULT('MyLocal')
          #PROMPT('Derive from which Class:',@s200),%qsDeriveClassName,DEFAULT('')
          #Prompt('Use Type Declaration?',Check),%qsType,AT(10)
        #ENDENABLE
      #ENDENABLE
    #ENDBOXED
  #ENDTAB
  #TAB('Class Properties')
        #ENABLE(%qsUseLocal = %TRUE)
          #BOXED('Class "Global" Properties'),section
            #BUTTON('Class "Global" Properties'),MULTI(%qslassVarMultiName,%qsVarName &  ' ' & %qsVarType & '(' & %qsVarSize & ') - Dim Size ('& %qsDimSize & ') !'& %qsVarComment),INLINE
              #PROMPT('Property Name:',@s150),%qsVarName,REQ
              #PROMPT('Property Type:',Drop('Byte|CString|Decimal|Like|Long|Signed|Short|String|ULong|Unsigned')),%qsVarType,Default('String'),REQ
              #ENABLE(UPPER(%qsVarType) = 'STRING' or UPPER(%qsVarType) = 'CSTRING' or UPPER(%qsVarType) = 'DECIMAL')
                #PROMPT('Characters:',@s20),%qsVarSize,Default('')
              #ENDENABLE
              #ENABLE(UPPER(%qsVarType) = 'DECIMAL')
                #PROMPT('Places:',@s20),%qsVarPlaces,Default('')
              #ENDENABLE
              #ENABLE(UPPER(%qsVarType) <> 'String' or UPPER(%qsVarType) <> 'CSTRING' or UPPER(%qsVarType) <> 'DECIMAL')
                #PROMPT('Initial Value:',@s20),%qsVarInitVal,Default(0)
              #ENDENABLE
              #Prompt('Dimensioned?',Check),%qsVarDim,AT(10)
              #ENABLE(%qsVarDim = %True)
                #PROMPT('Dimension Size:',@s20),%qsDimSize,Default(''),REQ
              #ENDENABLE
              #PROMPT('Property Comment:',@s150),%qsVarComment,Default('')
            #ENDBUTTON
            #Prompt('Global Data Embed',EmbedButton(%qsLocalClass1)),AT(196,45,65,15)
          #ENDBOXED
        #ENDENABLE
  #ENDTAB
  #TAB('Class Methods')
   #ENABLE(%qsUseLocal = %TRUE)
     #BUTTON('Class Methods'),MULTI(%qsProcedureMultiName,%qsProcedureName & ' : Pass Properties = ' & %qsProcParamYN),INLINE
       #PROMPT('Method Name:',@S200),%qsProcedureName,REQ
       #PROMPT('Method Type:',DROP('None|Derived|Virtual|Private|Public|Protected')),%qsProcedureType,REQ,Default('None')
       #Prompt('Return Procedure?',Check),%qsReturnProc,AT(100)
       #ENABLE(%qsReturnProc = %True)
          #PROMPT('Return Type:',Drop('Byte|Date|Long|Signed|String|ULong|Unsigned')),%qsReturnVar,Default('Byte'),REQ
          #ENABLE(UPPER(%qsReturnVar) = 'STRING')
                #PROMPT('Characters:',@s20),%qsReturnVarSize,Default(''),REQ
          #ENDENABLE
       #ENDENABLE
       #!    
       #Prompt('Data Embed',EmbedButton(%qsNLocalClassProcedures2,%qsProcedureName)),AT(210,75,50,15)
       #!                                                                           Column,Row,Len,Height
       #Prompt('Code Embed',EmbedButton(%qsNLocalClassProcedures3,%qsProcedureName)),AT(210,95,50,15)
       #!
       #Display('Passing Properties?'),AT(10,70,,)
       #PROMPT('',DROP('Yes|No')),%qsProcParamYN,DEFAULT('No'),AT(100,70,30,10)
       #ENABLE(%qsProcParamYN='Yes')
         #BOXED('Passing Properties/Parameters'),section
          #BUTTON('Passing Properties/Parameters'),MULTI(%qsProcParams,%qsProcParamsVariable & ' ' & %qsProcParamsType),AT(,,180),INLINE
           #PROMPT('Property Name:',@s150),%qsProcParamsVariable,REQ
           #PROMPT('Property Type:',Drop('Byte|Cstring|Date|Queue|Long|Signed|String|Time|ULong|Unsigned')),%qsProcParamsType,Default('String'),REQ
           #PROMPT('Pass by address:',Check),%qsProcPassByAddress
          #ENDBUTTON
         #ENDBOXED
       #ENDENABLE
       #!
       #BOXED('Method "Local" Properties'),section
            #BUTTON('Method "Local" Properties'),MULTI(%qslassVarLMultiName,%qsVarLName &  ' ' & %qsVarLType & '(' & %qsVarLSize & ',' & %qsVarLPlaces & ') - Dim Size ('& %qsDimLSize & ') !'& %qsVarLComment),INLINE
              #PROMPT('Property Name:',@s150),%qsVarLName,REQ
              #PROMPT('Property Type:',Drop('Byte|CString|Decimal|Like|Long|Signed|Short|String|ULong|Unsigned')),%qsVarLType,Default('String'),REQ
              #ENABLE(UPPER(%qsVarLType) = 'STRING' or UPPER(%qsVarLType) = 'CSTRING' or UPPER(%qsVarLType) = 'DECIMAL')
                #PROMPT('Characters:',@s20),%qsVarLSize,Default('')
              #ENDENABLE
              #ENABLE(UPPER(%qsVarLType) = 'DECIMAL')
                #PROMPT('Places:',@s20),%qsVarLPlaces,Default(0)
              #ENDENABLE
              #PROMPT('Initial Value:',@s20),%qsVarLInitVal,Default(0)
              #PROMPT('Dimensioned?',Check),%qsVarLDim,AT(10)
              #ENABLE(%qsVarLDim = %True)
                #PROMPT('Dimension Size:',@s20),%qsDimLSize,Default(''),REQ
              #ENDENABLE
              #PROMPT('Property Comment:',@s150),%qsVarLComment,Default('')
            #ENDBUTTON
       #ENDBOXED
       #!
     #ENDBUTTON
   #ENDENABLE
  #ENDTAB
#ENDSHEET
#!
#!
#!------------------------------------------------------------------------------------------------------------------------
#AT(%LocalDataAfterClasses),PRIORITY(8500),WHERE(UPPER(%Procedure)<>'SOURCE')
#INSERT  (%LOCALDATAGRP)
#ENDAT
#!
#!------------------------------------------------------------------------------------------------------------------------
#AT(%LocalData),PRIORITY(8500),WHERE(UPPER(%Procedure)='SOURCE')
#INSERT  (%LOCALDATAGRP)
#ENDAT
#!
#!------------------------------------------------------------------------------------------------------------------------
#At(%LocalProcedures),Description('Qualitas Solutions''s(Local) - Procedures')
#!
#!
#!Declare variables to work with
#DECLARE(%qsParamStringB)
#DECLARE(%qsReturnParamStringB)
#DECLARE(%qsParamCounterB)
#!
#!
#!Populate Methods/Procedure in Local Procedures
#EMBED(%qsLocalClassProcedures1,'Qualitas Solutions''s1 - Local Class Procedures - Begin')
#FOR(%qsProcedureMultiName)
 #!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    #!Build Return properties/parameter string for method/procedure in LOCAL PROCEDURE Embed
 #!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    #IF(%qsReturnProc = %True)
       #SET(%qsReturnParamStringB,'')
       #IF(UPPER(%qsReturnVar)='STRING')
           #SET(%qsReturnParamStringB,'ReturnValue           ' & %qsReturnVar & '(' & %qsReturnVarSize & '),Auto')
       #ELSE
           #SET(%qsReturnParamStringB,'ReturnValue           ' & %qsReturnVar & '(),Auto')
       #ENDIF
    #ENDIF
    #!
    #!
    #!Build properties/parameter string for method/procedure in Local Data Embed
    #IF(%qsProcParamYN = 'Yes')
       #SET(%qsParamStringB,'')
       #SET(%qsParamCounterB,0)
       #!Loop through all the properties/parameters for this procedure/method
       #FOR(%qsProcParams)
          #!##########################
          #! First Parameter
          #!##########################
          #IF(%qsParamCounterB = 0)
            #IF(%qsProcPassByAddress = %False)
               #SET(%qsParamStringB,%qsProcParamsType & ' ' & %qsProcParamsVariable)
            #ELSE
               #SET(%qsParamStringB,'*' & %qsProcParamsType & ' ' & %qsProcParamsVariable)
            #ENDIF
          #ELSE
          #!##########################
          #! Subsequent Parameters
          #!##########################
            #IF(%qsProcPassByAddress = %False)
               #SET(%qsParamStringB,%qsParamStringB & ', ' & %qsProcParamsType & ' ' & %qsProcParamsVariable)
            #ELSE
               #SET(%qsParamStringB,%qsParamStringB & ', *' & %qsProcParamsType & ' ' & %qsProcParamsVariable)
            #ENDIF
          #ENDIF
          #SET(%qsParamCounterB,%qsParamCounterB + 1)
       #ENDFOR
    #ENDIF
    #!                                   
    #!
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    #IF(%qsProcParamYN = 'No')                               #!No Parameters
        #If(%qsProcedureType='None')                         #!No Derive
%qsLocalClassName.%qsProcedureName     Procedure()
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        #Else
        #!If Derived or virtual procedure
%qsLocalClassName.%qsProcedureName     Procedure(),%qsProcedureType
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        #ENDIF
   #ELSE                                                    #!!!!!!! Parameters !!!!!!!!!!!
        #If(%qsProcedureType='None')                         #!No derive
%qsLocalClassName.%qsProcedureName     Procedure(%qsParamStringB)
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        #Else
%qsLocalClassName.%qsProcedureName     Procedure(%qsParamStringB),%qsProcedureType
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        #ENDIF
   #ENDIF

 #!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
 #!                 Local  Code Section Begins Here
 #!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
 #!DATA EMBED WAS HERE
 #IF(%qsReturnProc = %True)
%qsReturnParamStringB
 #ENDIF
 #!
 #!
 #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 #!Populate "Local" Parameters for Class in Procedure Embed
 #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 #COMMENT(67)
 #FOR(%qslassVarLMultiName)
  #IF(UPPER(%qsVarLType)='STRING' or UPPER(%qsVarLType) = 'CSTRING')
    #IF(%qsVarLDim = %False and %qsVarLSize <> '')
    #!If String or Cstring and no Dimension size
%[15]qsVarLName             %qsVarLType(%qsVarLSize)                     #<!%qsVarLComment
    #ELSIF(%qsVarLDim = %False and %qsVarLInitVal <> '')
    #!If String or Cstring and Dimension size
%[15]qsDVarLName             %qsVarLType(%qsVarLInitVal)                  #<!%qsVarLComment
    #Else
%[15]qsVarLName             %qsVarLType(%qsVarLSize),DIM(%qsDimLSize)     #<!%qsVarLComment
    #ENDIF
  #ELSIF(%qsVarLDim = %True)
  #!If NOT String or Cstring and Dimension size
%[15]qsVarLName             %qsVarLType,DIM(%qsDimLSize)                 #<!%qsVarLComment
  #ELSE
     #IF(%qsVarLInitVal = '' and UPPER(%qsVarLType)<>'DECIMAL')
     #!If NOT String or Cstring and no Dimension size or initial value
%[15]qsVarLName             %qsVarLType                                 #<!%qsVarLComment
     #ELSIF(UPPER(%qsVarLType)='DECIMAL')
     #!If Decimal
%[15]qsVarLName             %qsVarLType(%qsVarLSize,%qsVarLPlaces)     #<!%qsVarLComment
     #ELSE
     #!If NOT String or Cstring and no Dimension size AND initial value
%[15]qsVarLName             %qsVarLType(%qsVarLInitVal)                  #<!%qsVarLComment
     #ENDIF
  #ENDIF
#ENDFOR
#!
 #!Moved Embed here otherwise can not use variables defined on Extension template in a local window
#$! Add any additional Local properties here
#EMBED(%qsNLocalClassProcedures2,'Qualitas Solutions''s2 - Local Class Procedure - Data'),%qsProcedureName,DATA

!--------------------------------------------------------------------------------------------------------
   Code             
!--------------------------------------------------------------------------------------------------------
#EMBED(%qsNLocalClassProcedures3,'Qualitas Solutions''s3 - Local Class Procedures - Code'),%qsProcedureName

 #IF(%qsReturnProc = %True)
   Return ReturnValue
 #ENDIF
#ENDFOR
#!
#!
#ENDAT

#!------------------------------------------------------------------------------------------------------------------------
#GROUP(%SETCC)
  #BOXED (''),Section,AT(75,5,115,80)
     #DISPLAY ('Qualitas Solutions''s Local Class'),prop(PROP:FontStyle,700),prop(PROP:FontName,%AppTPLFontName)
     #DISPLAY (''),prop(PROP:FontStyle,700),prop(PROP:FontName,%AppTPLFontName)
     #DISPLAY ('Version 1.03'),prop(PROP:FontStyle,700),prop(PROP:FontName,%AppTPLFontName)
     #DISPLAY ('Copyright © 2011 by'),prop(PROP:FontName,%AppTPLFontName)
     #DISPLAY ('Qualitas Solution Pty Ltd'),prop(PROP:FontName,%AppTPLFontName)
     #DISPLAY ('www.qualitas-solutions.co.za'),prop(PROP:FontName,%AppTPLFontName)
  #ENDBOXED

#GROUP(%SETAPP)
#BOXED('Qualitas Solutions''s Local Class Templates'),SECTION,AT(,10,,55)
  #DISPLAY ('Create Local Classes in your procedures')
  #DISPLAY ('Prompt driven')
#ENDBOXED

#GROUP(%LOCALDATAGRP)
 #IF (%qsDisableLocalAll = %FALSE)
   #IF (%qsUseLocal = %TRUE)
     #EMBED(%qsLocalClass,'Qualitas Solutions''s - Local Class Object Definition - Begin')
     #!
     #!
     #!Declare variables to work with
     #DECLARE(%qsParamStringA)
     #DECLARE(%qsReturnParamStringA)
     #DECLARE(%qsParamCounter)
     #!
     #!
     #!Define the class in Local Data Embed
     #IF(%qsDeriveClassName = '')
       #IF(%qsType = %True)
%[22]qsLocalClassName    Class(),Type
       #ELSE
%[22]qsLocalClassName    Class()
       #ENDIF
     #ELSE
     #!Derive from another class
       #IF(%qsType = %True)
%[22]qsLocalClassName    Class(%qsDeriveClassName),Type
       #ELSE
%[22]qsLocalClassName    Class(%qsDeriveClassName)
       #END
     #ENDIF
     #!
     #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
     #!Populate "Global" Parameters for Class in Local Data Embed
     #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
     #COMMENT(67)
     #FOR(%qslassVarMultiName)
      #IF(UPPER(%qsVarType)='STRING' or UPPER(%qsVarType) = 'CSTRING')
        #IF(%qsVarDim = %False and %qsVarSize <> '')
        #!If String or Cstring and no Dimension size
%[15]qsVarName             %qsVarType(%qsVarSize)                      #<!%qsVarComment
        #ELSIF(%qsVarDim = %False and %qsVarInitVal <> '')
        #!If String or Cstring and no Dimension size
%[15]qsDVarName             %qsVarType(%qsVarInitVal)                   #<!%qsVarComment
        #!If String or Cstring and Dimension size
        #ELSE
%[15]qsVarName             %qsVarType(%qsVarSize),DIM(%qsDimSize)       #<!%qsVarComment
        #ENDIF
      #ELSIF(%qsVarDim = %True)
        #!If NOT String or Cstring and Dimension size
%[15]qsVarName             %qsVarType,DIM(%qsDimSize)                  #<!%qsVarComment
      #ELSE
        #IF(%qsVarInitVal = '')
        #!If NOT String or Cstring and no Dimension size or initial value
%[15]qsVarName             %qsVarType                                 #<!%qsVarComment
        #ELSE
        #!If NOT String or Cstring and no Dimension size AND initial value
%[15]qsDVarName             %qsVarType(%qsVarInitVal)                   #<!%qsVarComment
        #ENDIF
      #ENDIF
     #ENDFOR
     #!
     #!
     #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
     #!Populate Methods/Procedures in LOCAL DATA
     #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
     #FOR(%qsProcedureMultiName)
         #!
         #!
     #!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         #!Build Return properties/parameter string 
     #!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         #! Procedure Return a value
         #!###########################
         #IF(%qsReturnProc = %True)
            #SET(%qsReturnParamStringA,'')
            #SET(%qsReturnParamStringA,%qsReturnVar & ',Proc')
         #ENDIF
         #!
         #!
         #!Build properties/parameter string for method/procedure in Local Data Embed
         #!#########################################################################
         #IF(%qsProcParamYN = 'Yes')
            #SET(%qsParamStringA,'')
            #SET(%qsParamCounter,0)
            #!Loop through all the properties/parameters for this procedure/method
            #FOR(%qsProcParams)
               #!##########################
               #! First Parameter
               #!##########################
               #IF(%qsParamCounter = 0)
                 #IF(%qsProcPassByAddress = %False)
                    #SET(%qsParamStringA,%qsProcParamsType & ' ' & %qsProcParamsVariable)
                 #ELSE
                    #SET(%qsParamStringA,'*' & %qsProcParamsType & ' ' & %qsProcParamsVariable)
                 #END
               #ELSE
               #!##########################
               #! Subsequent Parameters
               #!##########################
                 #IF(%qsProcPassByAddress = %False)
                    #SET(%qsParamStringA,%qsParamStringA & ', ' & %qsProcParamsType & ' ' & %qsProcParamsVariable)
                 #ELSE
                    #SET(%qsParamStringA,%qsParamStringA & ', *' & %qsProcParamsType & ' ' & %qsProcParamsVariable)
                 #ENDIF
               #ENDIF
               #SET(%qsParamCounter,%qsParamCounter + 1)
            #ENDFOR
         #ENDIF
         #!
         #!
     #!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
     #!  Populate Procedure call for method/procedure in Local Data Embed
     #!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         #IF(%qsProcParamYN = 'No')                               #!No Parameters
             #If(%qsProcedureType='None')                         #!No Derive
                #IF(%qsReturnProc = %True)                        #!Have Return Variable
%[23]qsProcedureName     Procedure(),%qsReturnParamStringA
                #ELSE
%[23]qsProcedureName     Procedure()
                #ENDIF
             #Else                                               #!Derived Yes
%[23]qsProcedureName     Procedure(),%qsProcedureType
             #ENDIF
        #ELSE                                                    #!!!!!!! Parameters !!!!!!!!!!!
             #If(%qsProcedureType='None')                         #!No Derive
                #IF(%qsReturnProc = %True)                        #!Have Return Variable
%[23]qsProcedureName     Procedure(%qsParamStringA),%qsReturnParamStringA
                #ELSE
%[23]qsProcedureName     Procedure(%qsParamStringA)
                #END
             #Else
%[23]qsProcedureName     Procedure(%qsParamStringA),%qsProcedureType
             #ENDIF
        #ENDIF
     #!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
     #ENDFOR
#EMBED(%qsLocalClass1,'Qualitas Solutions''s - Local Class Object Definition - End')
                          End
   #ENDIF
 #ENDIF