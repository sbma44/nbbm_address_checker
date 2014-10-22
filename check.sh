#!/bin/sh

rm -rf address_point_shapefiles && mkdir address_point_shapefiles
rm -f check.zip

for a in `cat shapefile_urls.csv`; do
    curl $a > check.zip

    # record archive contents so we can check script correctness
    echo "--- $a" >> archive_contents.txt
    unzip -l check.zip >> archive_contents.txt
    
    contains_file=`unzip -l check.zip | grep -i "address" | wc -l`
    if [ $contains_file -gt 0 ]; then
        echo "
>>> $a contains address points!
"
        filename=`unzip -l check.zip | grep -i "address" | sed -e "s/.*:..   //g"`
        unzip -o check.zip $filename
    else
        echo "
>>> $a does NOT contain address points
"
    fi
    rm check.zip
done