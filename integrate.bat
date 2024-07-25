rmdir /S /Q "art"
rmdir /S /Q "world"

for /D %%p in (parts\*) do (
  robocopy "%%p/art" "art" /S /xf .gitignore
  robocopy "%%p/world/ai" "world/ai" /S /xf .gitignore
  robocopy "%%p/world/contentdb" "world/contentdb" /S /xf .gitignore
  robocopy "%%p/world/global" "world/global" /S /xf .gitignore
)
