#!/bin/bash
set -e

# Make new directory for package school version
if [ ! -d "package" ]; then
  echo "Missing package folder, creating it..."
  mkdir package
# If package folder is present, then overwrite contents
else
  echo "Package folder is already present. Overwriting contents..."
  rm -rf package/*
fi

cp *.html package/
cp video/index.html package/video.html
cp recipe/index.html package/recipe.html
cp contact/index.html package/contact.html
cp -r css package/css
cp -r img package/img
cp -r fonts package/fonts
cp favicon.ico package/
rm -f package/img/vidicon.svg

cd package

# Sed commands to replace path for example ../recipe/index.html to recipe.html
# Also sed for index.html to replace path example recipe/index.html to recipe.html
for f in *.html; do
  sed -i \
    -e 's|../recipe/index.html|recipe.html|g' \
    -e 's|../video/index.html|video.html|g' \
    -e 's|../contact/index.html|contact.html|g' \
    -e 's|../css/style.css|css/style.css|g' \
    -e 's|../img/|img/|g' \
    -e 's|recipe/index.html|recipe.html|g' \
    -e 's|video/index.html|video.html|g' \
    -e 's|contact/index.html|contact.html|g' \
    -e 's|css/style.css|css/style.css|g' \
    -e 's|../favicon.ico|favicon.ico|g' \
    "$f"
done

# After all replacements, zip the package folder wwith compression level 9
zip -r9 ../RedSoup-MartinEesmaa-school.zip ./*
cd ..
# Clean up the package folder
rm -rf package
echo "Package school version created."
echo "You can test by unzip and test the HTML files."
echo "Have fun with the school version of Red Soup!"
# Exit with success
exit 0