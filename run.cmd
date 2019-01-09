@rem =========================================================================
@rem quick start script
@rem author: pengr
@rem -------------------------------------------------------------------------
@echo off

set command=%~1

if %command% == serve (
    docsify serve
) else if %command% == BrainIdeas (
    set dir=BrainIdeas
    goto CreateDocument
REM ) else if %command% == issue (

REM ) else if %command% == LeetCode (

) else if %command% == -h (
    echo    -- serve ^

        "Start the server , you can listening at http://localhost:3000"
    echo    -- BrainIdeas ^

        "Follow the BrainIdeas template to create a document"
    echo    -- issue  ^

        "Follow the issue template to create a document"
    echo    -- LeetCode ^

        "Follow the LeetCode template to create a document"
    goto End
)

:CreateDocument
set file=%~2
if "%file%"=="" (
    echo create %dir%\%file%.md file successfully! please input the file name
    goto End
) 
type %dir%\Template.md > %dir%\%file%.md
echo create %dir%\%file%.md file successfully
goto End

:End
@rem ---------------------------------------------------------------------
@rem end command
@rem ---------------------------------------------------------------------
goto :EOF
