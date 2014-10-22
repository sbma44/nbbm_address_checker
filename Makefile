shapefile_urls.csv:
	curl http://www.broadbandmap.gov/data-download | grep "href=\".*-SHP-.*\.zip" | grep -v All-NBM | sed -e "s/<td><a href=\"//g" -e "s/zip\">.*/zip/g" > shapefile_urls.csv

check: shapefile_urls.csv
	sh check.sh