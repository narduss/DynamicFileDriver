#Template(qsDFDClass,'Qualitas - DFD SQL Select Class'),FAMILY('ABC')
#!---------------------------------------------------------------------------------
#SYSTEM
  #EQUATE(%AppTPLFontName,'Tahoma')
#!  
#!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#!                                               APPLICATION EXTENSION
#!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#!
#EXTENSION(qsDFDGlobal,'Activate Qualitas Solutions''s DFD SQL Select - Global'),APPLICATION
#!
#SHEET
#! Custom for this template
#!------------------------------------------------------------------------------------------------------------------------
 #TAB('General')
    #INSERT  (%SETCC)
    #INSERT  (%SETAPP)
    #DISPLAY ('')
    #PROMPT  ('Use StringTheory for SQL Query?',check),%qsDFDUseStringTheory,AT(10),prop(PROP:FontName,%AppTPLFontName)
    #PROMPT  ('Is this a Nettalk Web App?',check),%qsDFDNettalkWeb,AT(10),prop(PROP:FontName,%AppTPLFontName)
    #DISPLAY ('')
    #BOXED   ('Debugging'),Section,AT(,100,,20)
       #PROMPT  ('Disable Qualitas''s DFD SQL Select Templates',Check),%qsDFDDisableGlobal,AT(10),prop(PROP:FontName,%AppTPLFontName)
    #ENDBOXED
 #ENDTAB
#ENDSHEET
#!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#!                                               PROCEDURE EXTENSION
#!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#!
#! DFD
#!
#!
#EXTENSION (qsDFDProcedure, 'Qualitas''s DFD From SQL Select - Procedure'), PROCEDURE, REQ(qsDFDGlobal)
#SHEET
  #TAB('General')
    #DISPLAY (''),prop(PROP:FontName,%AppTPLFontName)
    #DISPLAY ('This Procedure Extension defines the DFD Class'),prop(PROP:FontName,%AppTPLFontName)
    #DISPLAY ('and DFD File Name that will be used. Also '),prop(PROP:FontName,%AppTPLFontName)
    #DISPLAY ('defines a StringTheory Class if specified.'),prop(PROP:FontName,%AppTPLFontName)
    #PROMPT  ('DFD Classname:',@s30),%qsDFDClassName,REQ,DEFAULT('qsDFDClass'),prop(PROP:FontName,%AppTPLFontName)
    #PROMPT  ('DFD New File name:',@s30),%qsDFDNewFileName,REQ,DEFAULT('qsDFDFile'),prop(PROP:FontName,%AppTPLFontName)
    #ENABLE(%qsDFDUseStringTheory = 0)
       #PROMPT  ('SQL Select Var:',Field),%qsDFDSQLSelect,REQ,prop(PROP:FontName,%AppTPLFontName)
    #ENDENABLE  
    #ENABLE(%qsDFDUseStringTheory = 1)
       #PROMPT  ('StringTheory Classname:',@s30),%qsDFDstClassName,REQ,DEFAULT('qsStClass'),prop(PROP:FontName,%AppTPLFontName)
    #ENDENABLE
    #PROMPT  ('Copy Result to Mem-Driver',Check),%qsDFDMemDriverResult,prop(PROP:FontName,%AppTPLFontName)
    #DISPLAY (''),prop(PROP:FontName,%AppTPLFontName)
  #ENDTAB 
#ENDSHEET  

#AT(%DataSection)
 #IF(%qsDFDDisableGlobal = 0)
 !Added by qsDFDProcedure
%qsDFDClassName	   DynFile   	  !Class Definition
%qsDFDNewFileName  	&File		     !New Dynamic File
  #IF(%qsDFDUseStringTheory = 1)
%qsDFDstClassName       StringTheory 
  #ENDIF
  #IF(%qsDFDMemDriverResult = 1)
DFDMemClass    	   DynFile   	  !MEM Result Class Definition  
  #ENDIF
 #ENDIF 
#ENDAT    

#!
#!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#!                                               CODE EXTENSION
#!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#CODE(qsDFDCode,'Qualitas''s DFD From SQL Select - Code'),REQ(qsDFDProcedure)
 #DISPLAY (''),prop(PROP:FontName,%AppTPLFontName)
 #DISPLAY ('This Code Template creates a Dynamic File (DFD) and'),prop(PROP:FontName,%AppTPLFontName)
 #DISPLAY ('execute SQL code against a SQL database. The result'),prop(PROP:FontName,%AppTPLFontName)
 #DISPLAY ('set is accessable via the new DFD file.'),prop(PROP:FontName,%AppTPLFontName)
 #PROMPT  ('Database Driver:',Drop('MSSQL|MEMORY|ODBC|TPS')),%qsDFDDriver,REQ,DEFAULT('MSSQL'),prop(PROP:FontName,%AppTPLFontName)
 #ENABLE(%qsDFDDriver='MSSQL' or %qsDFDDriver='ODBC')
     #PROMPT  ('Database Owner:',@S50),%qsDFDOwner,REQ,DEFAULT('GLO:DBOwner'),prop(PROP:FontName,%AppTPLFontName)
     #PROMPT  ('Driver string:',@S50),%qsDFDDriverString,prop(PROP:FontName,%AppTPLFontName)
 #ENDENABLE
 #ENABLE(%qsDFDDriver='MEMORY' or %qsDFDMemDriverResult=1)
     #PROMPT  ('In-Memory FileName:',@S30),%qsDFDMemName,REQ,DEFAULT('<39>qsDFDMemFile'&%ActiveTemplateInstance&'<39>'),prop(PROP:FontName,%AppTPLFontName)
 #ENDENABLE
 #PROMPT  ('Display Error Messages?',Check),%qsDFDDisplayErrorMessage,Default(1),prop(PROP:FontName,%AppTPLFontName)
 #DISPLAY (''),prop(PROP:FontName,%AppTPLFontName)
 #DISPLAY ('Example assignment:'),prop(PROP:FontName,%AppTPLFontName)
 #DISPLAY ('   LOC:AnyVar = Clip(qsDFDClass.GetField(''ID''))'),prop(PROP:FontName,%AppTPLFontName)
 #DISPLAY (''),prop(PROP:FontName,%AppTPLFontName)
 #DISPLAY ('Code for assignments:'),prop(PROP:FontName,%AppTPLFontName)
 #PROMPT  ('Execute Code',@S250),%qsDFDExecuteCode,prop(PROP:FontName,%AppTPLFontName)
 #DISPLAY (''),prop(PROP:FontName,%AppTPLFontName)
 
 #IF(%qsDFDDisableGlobal = 0)
  !Added by qsDFDCode
  #IF(%qsDFDUseStringTheory = 0)
  !Example of select
  !%qsDFDSQLSelect = 'SELECT ContactID as ID, ContactName as ContactName FROM Contacts Order by ContactName'
  #ELSE
  !Example of assignment of select
  !%qsDFDstClassName.Assign('SELECT ContactID as ID, ContactName as ContactName FROM Contacts Order by ContactName')
  #ENDIF
  %qsDFDClassName.UnfixFormat()                           !Clears the current structure assigned to the dynamic file
  %qsDFDClassName.ResetAll() 
  %qsDFDClassName.SetDriver('%qsDFDDriver')
  #IF(%qsDFDDriver='MSSQL')
  %qsDFDClassName.SetOwner(%qsDFDOwner)
    #IF(%qsDFDDriverString<>'')
  %qsDFDClassName.SetDriverstring(%qsDFDDriverString)
    #ENDIF
  #ELSIF(%qsDFDDriver='MEMORY')
  %qsDFDClassName.SetName(%qsDFDMemName)
  #ENDIF
  !This is important:
  !If you are using "as" in your SQL statement you have to use those "as" values in the GetField/GetFieldValue
  #IF(%qsDFDUseStringTheory = 0)
  %qsDFDClassName.CreateFromSQL(%qsDFDSQLSelect)
  #ELSE
  %qsDFDClassName.CreateFromSQL(%qsDFDstClassName.GetVal())
  #ENDIF
  If ErrorCode()
     #IF(%qsDFDNettalkWeb = 0)
        #IF(%qsDFDDisplayErrorMessage = 1)
     Message('Create From SQL Error = '& Error() & '. FileError = ' & FileError())
        #ENDIF
     #ELSE
        #IF(%qsDFDDisplayErrorMessage = 1)
     p_web.trace('Create From SQL Error for TemplateInstance(%ActiveTemplateInstance) = '& Error() & '. FileError = ' & FileError())
        #ENDIF
     #ENDIF
  Else
     #IF(%qsDFDMemDriverResult=0)
     %qsDFDNewFileName &= %qsDFDClassName.GetFileRef()                 !Get reference to the dynamic file you created
     #ELSE
     DFDMemClass.UnfixFormat()
     DFDMemClass.ResetAll()
     DFDMemClass.SetCreate(True)
     DFDMemClass.SetName(%qsDFDMemName)
     DFDMemClass.SetDriver('MEMORY')
     DFDMemClass.FillFrom(%qsDFDClassName)
     %qsDFDNewFileName &= DFDMemClass.GetFileRef()                 !Get reference to the dynamic file you created
     #ENDIF
     Open(%qsDFDNewFileName)
     #IF(%qsDFDMemDriverResult=1)
     Set(%qsDFDNewFileName)
     Loop I# = 1 to Records(%qsDFDNewFileName)
     #ELSE
     Loop 
     #ENDIF
        Next(%qsDFDNewFileName)
        If ErrorCode()
           #IF(%qsDFDNettalkWeb = 0)
              #IF(%qsDFDDisplayErrorMessage = 1)
           If ErrorCode() = 33
              Message('Record not available','Error')
           Else
              Message('Error = ' & Error() & '. Error Code = ' & ErrorCode() & '.| FileError = ' & FileError(),'Error')
           End                                  
              #ENDIF
           #ELSE
              #IF(%qsDFDDisplayErrorMessage = 1)
           If ErrorCode() = 33
              p_web.trace('Record Not Available - Usually an attempt to read past the end of file with NEXT')
           Else
              p_web.trace('Error for TemplateInstance(%ActiveTemplateInstance) = ' & Error() & '. Error Code = ' & ErrorCode() & '. FileError = ' & FileError())
           End
              #ENDIF
           #ENDIF
           Break
        Else
           !Do assignments here
           !%qsDFDClassName.GetField('ID')
           !The following code is supplied by you in a template prompt
           %qsDFDExecuteCode
        End
     End
     Close(%qsDFDNewFileName)   
  End
  #IF(%qsDFDUseStringTheory = 1)    
  %qsDFDstClassName.Free()
  #ENDIF
 #ENDIF

#!------------------------------------------------------------------------------------------------------------------------
#GROUP(%SETCC)
  #BOXED (''),Section,AT(75,5,115,80)
     #DISPLAY ('Qualitas Solutions''s DFD SQL'),prop(PROP:FontStyle,700),prop(PROP:FontName,%AppTPLFontName)
     #DISPLAY ('Select'),prop(PROP:FontStyle,700),prop(PROP:FontName,%AppTPLFontName)
     #DISPLAY ('Version 1.00'),prop(PROP:FontStyle,700),prop(PROP:FontName,%AppTPLFontName)
     #DISPLAY ('Copyright © 2018 by'),prop(PROP:FontName,%AppTPLFontName)
     #DISPLAY ('Qualitas Solution Pty Ltd'),prop(PROP:FontName,%AppTPLFontName)
     #DISPLAY ('www.qualitas-solutions.co.za'),prop(PROP:FontName,%AppTPLFontName)
  #ENDBOXED

#!------------------------------------------------------------------------------------------------------------------------
#GROUP(%SETAPP)
#BOXED('Qualitas Solutions DFD SQL Templates'),SECTION,AT(,20,,35)
  #DISPLAY ('DFD SQL Select')
  #DISPLAY ('Uses DFD driver to return data to dynamic table')
#ENDBOXED