rmdir /S /Q "art"
rmdir /S /Q "sound"
rmdir /S /Q "ui"
rmdir /S /Q "world/ai"
rmdir /S /Q "world/contentdb"
rmdir /S /Q "world/global"
::rmdir /S /Q "world/maps/collab24/index"
rmdir /S /Q "world/maps/collab24/info"
rmdir /S /Q "world/maps/collab24/quests"
rmdir /S /Q "world/maps/collab24/regions"

for /D %%p in (parts\*) do (
  robocopy "%%p/art" "art" /S /xf .gitignore
  robocopy "%%p/sound" "sound" /S /xf .gitignore
  robocopy "%%p/ui" "ui" /S /xf .gitignore
  robocopy "%%p/world/ai" "world/ai" /S /xf .gitignore
  robocopy "%%p/world/contentdb" "world/contentdb" /S /xf .gitignore
  robocopy "%%p/world/global" "world/global" /S /xf .gitignore
  for /D %%m in (%%p\world\maps\*) do (
    robocopy "%%m/regions" "world/maps/collab24/regions" /S /xf .gitignore /xd "*_pre" /xd "*_post"
  )
)
for /D %%m in (world\maps\collab24-dummy*) do (
  robocopy "%%m/regions" "world/maps/collab24/regions" /S /xf .gitignore /xd "*_pre" /xd "*_post"
)

pushd %gaspy%
venv\Scripts\python -m integrate_collab "%~dp0." collab24
if %errorlevel% neq 0 pause
popd

pause
