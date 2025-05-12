#!/bin/bash

git pull

rm -rf working complete
mkdir -p working/{creative,complete/creative}
cd working/creative || exit

mkdir -p assets/minecraft/{textures,models}
rsync -a ../../merch/models/block assets/minecraft/models/block
rsync -a ../../merch/textures/ assets/minecraft/textures
cp ../../pack.mcmeta pack.mcmeta
cp ../../pack.png pack.png

zip -r creativepack.zip assets pack.mcmeta pack.png
cd ../../

mkdir -p working/{hub,complete/hub}
cd working/hub || exit

mkdir -p assets/minecraft/{textures,models}
rsync -a ../../merch/models/block assets/minecraft/models/block
rsync -a ../../merch/textures/ assets/minecraft/textures
cp ../../pack.mcmeta pack.mcmeta
cp ../../pack.png pack.png

zip -r hubpack.zip assets pack.mcmeta pack.png
cd ../../

mv working/hub/hubpack.zip working/complete/hubpack.zip
mv working/creative/creativepack.zip working/complete/creativepack.zip
mkdir -p working/convert/template
cp working/complete/*.zip working/convert/template
wget https://jenkins.dc1.agentdid127.com/job/agentdid127/job/ResourcePackConverter/job/dev%252F1.21.4/lastSuccessfulBuild/artifact/Applications/Console/target/ResourcePackConverter-Console-2.2.5.jar

cp -r working/convert/template working/convert/1_21_4
cd working/convert/1_21_4/
java -jar ../../../ResourcePackConverter-Console-*.jar --from 1.15.2 --to 1.21.4 --minify
rm hubpack.zip
rm creativepack.zip
mv hubpack_converted.zip ../../complete/hubpack-1.21.4.zip
mv creativepack_converted.zip ../../complete/creativepack-1.21.4.zip
cd ../../../

mv working/complete .
rm -rf working
rm -f ResourcePackConverter-*.jar
