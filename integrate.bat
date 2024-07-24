rmdir /S /Q "art"
rmdir /S /Q "world"

robocopy "parts/firstie/art" "art" /S /xf .gitignore
robocopy "parts/firstie/world/ai" "world/ai" /S /xf .gitignore
robocopy "parts/firstie/world/contentdb" "world/contentdb" /S /xf .gitignore
robocopy "parts/firstie/world/global" "world/global" /S /xf .gitignore

robocopy "parts/andreou/art" "art" /S /xf .gitignore
robocopy "parts/andreou/world/ai" "world/ai" /S /xf .gitignore
robocopy "parts/andreou/world/contentdb" "world/contentdb" /S /xf .gitignore
robocopy "parts/andreou/world/global" "world/global" /S /xf .gitignore
