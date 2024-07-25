rmdir /S /Q "art"
rmdir /S /Q "world/ai"
rmdir /S /Q "world/contentdb"
rmdir /S /Q "world/global"
rmdir /S /Q "world/maps/collab24/regions"

for /D %%p in (parts\*) do (
  robocopy "%%p/art" "art" /S /xf .gitignore
  robocopy "%%p/world/ai" "world/ai" /S /xf .gitignore
  robocopy "%%p/world/contentdb" "world/contentdb" /S /xf .gitignore
  robocopy "%%p/world/global" "world/global" /S /xf .gitignore
  for /D %%m in (%%p\world\maps\collab24*) do (
    robocopy "%%m/regions" "world/maps/collab24/regions" /S /xf .gitignore /xd "*_pre" /xd "*_post"
  )
)
