@rem =========================================================================
@rem quick start script
@rem author: pengr
@rem -------------------------------------------------------------------------
@echo off

set command=%~1

if %command% == serve (
    docsify serve
) else if %command% == BrainIdeas (
    set dir = BrainIdeas
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
REM type %dir%/Template.md > %dir%/%~2.md
echo %dir%/%~2.md
goto End

:End
@rem ---------------------------------------------------------------------
@rem end command
@rem ---------------------------------------------------------------------
goto :EOF
