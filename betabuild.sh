#!/bin/bash

git pull

rm -rf working complete
# This is a basic workflow to help you get started with Actions
# Set up Creative
mkdir -p working/{creative,complete/creative}
cd working/creative || exit

mkdir -p assets/minecraft/{textures,models}
rsync -a ../../creative/models/block assets/minecraft/models/block
rsync -a ../../creative/textures/ assets/minecraft/textures
rsync -a ../../common/models/block assets/minecraft/models/block
rsync -a ../../common/textures/ assets/minecraft/textures

cp ../../pack.mcmeta pack.mcmeta
cp ../../pack.png pack.png
zip -r creativepack.zip assets pack.mcmeta pack.png
cd ../../

# Set up Hub         
mkdir -p working/{hub,complete/hub}
cd working/hub || exit

mkdir -p assets/minecraft/{textures,models}
rsync -a ../../hub/models/block assets/minecraft/models/block
rsync -a ../../hub/models/vehicles assets/minecraft/models/vehicles
rsync -a ../../hub/models/default assets/minecraft/models/item
rsync -a ../../hub/textures/ assets/minecraft/textures
rsync -a ../../common/models/block assets/minecraft/models/block
rsync -a ../../common/textures/ assets/minecraft/textures
cp ../../pack.mcmeta pack.mcmeta
cp ../../pack.png pack.png

zip -r hubpack.zip assets pack.mcmeta pack.png
cd ../../
    
# Set up Resource Pack Converter

mv working/hub/hubpack.zip working/complete/hubpack.zip
mv working/creative/creativepack.zip working/complete/creativepack.zip
mkdir -p working/convert/template
cp working/complete/*.zip working/convert/template
wget https://jenkins.dc1.agentdid127.com/job/agentdid127/job/ResourcePackConverter/job/dev%252F1.21.4/lastSuccessfulBuild/artifact/Applications/Console/target/ResourcePackConverter-Console-2.2.5.jar

# Convert Packs      
cp -r working/convert/template working/convert/1_21_4
cd working/convert/1_21_4/
java -jar ../../../ResourcePackConverter-Console-*.jar --from 1.15.2 --to 1.21.4 --minify
rm hubpack.zip
rm creativepack.zip
mv hubpack_converted.zip ../../complete/hubpack-1.21.4.zip
mv creativepack_converted.zip ../../complete/creativepack-1.21.4.zip
cd ../../../

cp -r working/convert/template working/convert/1_21_2
cd working/convert/1_21_2/
java -jar ../../../ResourcePackConverter-Console-*.jar --from 1.15.2 --to 1.21.2 --minify
rm hubpack.zip
rm creativepack.zip
mv hubpack_converted.zip ../../complete/hubpack-1.21.2.zip
mv creativepack_converted.zip ../../complete/creativepack-1.21.2.zip
cd ../../../

cp -r working/convert/template working/convert/1_21_1
cd working/convert/1_21_1/
java -jar ../../../ResourcePackConverter-Console-*.jar --from 1.15.2 --to 1.21.1 --minify
rm hubpack.zip
rm creativepack.zip
mv hubpack_converted.zip ../../complete/hubpack-1.21.1.zip
mv creativepack_converted.zip ../../complete/creativepack-1.21.1.zip
cd ../../../

cp -r working/convert/template working/convert/1_20_4
cd working/convert/1_20_4/
java -jar ../../../ResourcePackConverter-Console-*.jar --from 1.15.2 --to 1.20.4 --minify
rm hubpack.zip
rm creativepack.zip
mv hubpack_converted.zip ../../complete/hubpack-1.20.4.zip
mv creativepack_converted.zip ../../complete/creativepack-1.20.4.zip
cd ../../../

mv working/complete .

rm -rf working
rm -f ResourcePackConverter-*.jar