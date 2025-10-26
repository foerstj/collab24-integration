:: name of map
set map=collab24
set res=%map%
:: name of map, case-sensitive
set map_cs=Collab 2024 - The Goblin Menace
:: tank properties
set year=2025
set copyright=CC-BY-SA %year%
set author=Eksevis, EmirGhanawa, Firstie, Sadowson, Andreou
set title=%map_cs%

:: path of Bits dir
set bits=%~dp0.
:: path of DS installation
set ds=%DungeonSiege%
:: path of TankCreator
set tc=%TankCreator%

:: param
set mode=%1
echo %mode%

:: pre-build checks
setlocal EnableDelayedExpansion
if not "%mode%"=="light" (
  robocopy "%bits%\original\templates" "%bits%\world\contentdb\templates\original" /S
  robocopy "%bits%\original\moods" "%bits%\world\global\moods\original" /S
  pushd %gaspy%
  set checks=standard
  if "%mode%"=="release" (
    set checks=all
  )
  venv\Scripts\python -m build.pre_build_checks %map% --check !checks! --bits "%bits%"
  set pre_build_checks_errorlevel=!errorlevel!
  rmdir /S /Q "%bits%\world\contentdb\templates\original"
  rmdir /S /Q "%bits%\world\global\moods\original"
  if !pre_build_checks_errorlevel! neq 0 pause
  popd
)
endlocal

:: Compile map file
rmdir /S /Q "%tmp%\Bits"
robocopy "%bits%\world\maps\%map%" "%tmp%\Bits\world\maps\%map%" /S
setlocal EnableDelayedExpansion
pushd %gaspy%
venv\Scripts\python -m build.fix_start_positions_required_levels %map% --bits "%tmp%\Bits"
if %errorlevel% neq 0 pause

if "%mode%"=="release" (
  robocopy "%bits%\original\templates" "%bits%\world\contentdb\templates" /S
  venv\Scripts\python -m build.add_world_levels %map% --bits "%tmp%\Bits" --template-bits "%bits%"
  set add_world_levels_errorlevel=!errorlevel!
  rmdir /S /Q "%bits%\world\contentdb\templates\regular"
  rmdir /S /Q "%bits%\world\contentdb\templates\veteran"
  rmdir /S /Q "%bits%\world\contentdb\templates\elite"
  if !add_world_levels_errorlevel! neq 0 pause
)
popd
endlocal
"%tc%\RTC.exe" -source "%tmp%\Bits" -out "%ds%\DSLOA\%map_cs%.dsmap" -copyright "%copyright%" -title "%title%" -author "%author%"
if %errorlevel% neq 0 pause

:: Compile resource file
rmdir /S /Q "%tmp%\Bits"
robocopy "%bits%\art" "%tmp%\Bits\art" /S
robocopy "%bits%\sound" "%tmp%\Bits\sound" /S
robocopy "%bits%\ui" "%tmp%\Bits\ui" /S
robocopy "%bits%\world\ai" "%tmp%\Bits\world\ai" /S
robocopy "%bits%\world\contentdb\components" "%tmp%\Bits\world\contentdb\components" /S
robocopy "%bits%\world\contentdb\templates\%res%" "%tmp%\Bits\world\contentdb\templates\%res%" /S
robocopy "%bits%\world\contentdb\templates\minibits" "%tmp%\Bits\world\contentdb\templates\minibits" /S
robocopy "%bits%\world\global" "%tmp%\Bits\world\global" /S
"%tc%\RTC.exe" -source "%tmp%\Bits" -out "%ds%\DSLOA\%map_cs%.dsres" -copyright "%copyright%" -title "%title%" -author "%author%"
if %errorlevel% neq 0 pause
