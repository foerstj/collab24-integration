:: name of map
set map=collab24
set res=%map%
:: name of map, case-sensitive
set map_cs=Collab 24
:: tank properties
set year=2024
set copyright=CC-BY-SA %year%
set author=Eksevis, EmirGhanawa, Firstie, Sadowson, Andreou
set title=%map_cs%

:: path of DSLOA documents dir (where Bits are)
set doc_dsloa=%USERPROFILE%\Documents\Dungeon Siege LoA
:: path of DS installation
set ds=%DungeonSiege%
:: path of TankCreator
set tc=%TankCreator%

:: Compile map file
rmdir /S /Q "%tmp%\Bits"
robocopy "%doc_dsloa%\Bits\world\maps\%map%" "%tmp%\Bits\world\maps\%map%" /S
pushd %gaspy%
venv\Scripts\python -m build.fix_start_positions_required_levels %map% "%tmp%\Bits"
if %errorlevel% neq 0 pause
popd
"%tc%\RTC.exe" -source "%tmp%\Bits" -out "%ds%\DSLOA\%map_cs%.dsmap" -copyright "%copyright%" -title "%title%" -author "%author%"
if %errorlevel% neq 0 pause

:: Compile resource file
rmdir /S /Q "%tmp%\Bits"
robocopy "%doc_dsloa%\Bits\art" "%tmp%\Bits\art" /S
robocopy "%doc_dsloa%\Bits\world\ai" "%tmp%\Bits\world\ai" /S
robocopy "%doc_dsloa%\Bits\world\contentdb" "%tmp%\Bits\world\contentdb" /S
robocopy "%doc_dsloa%\Bits\world\global" "%tmp%\Bits\world\global" /S
"%tc%\RTC.exe" -source "%tmp%\Bits" -out "%ds%\DSLOA\%map_cs%.dsres" -copyright "%copyright%" -title "%title%" -author "%author%"
if %errorlevel% neq 0 pause
