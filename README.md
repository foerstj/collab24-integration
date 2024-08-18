# collab24-integration
Integration environment for integrating the five map parts into one map.

## Howto
- The five parts are included as git submodules in the "parts" folder
- The world/maps/collab24/main.gas is provided directly in this repo
- You need GasPy https://github.com/foerstj/gaspy checked out and with pip dependencies installed
- Run integrate.bat - you need to provide the GasPy path as %gaspy% environment variable
- When successful, open Siege Editor - the integration repo should be your Bits folder
- Run Siege Editor -> Tools -> Stitch Builder -> Build Stitches -> collab24 - this is annoyingly a manual step
- Add /original/templates and /original/moods for pre-build checks, the /original folder is git-ignored
- Run build.bat - you need to provide %gaspy%, %DungeonSiege% and %TankCreator% paths as environment variables
- Behold, %DungeonSiege%/DSLOA now contains "Collab 24.dsmap" and "Collab 24.dsres"
