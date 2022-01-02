#!/bin/bash

set -e
set -o pipefail
# set -x

function echo_heading () {
	echo -e "\n\n$(tput bold)$1$(tput sgr0)\n"
}



echo_heading 'downloading & extracting the DELFI GTFS feed'

wget -c -N -q 'https://de.data.public-transport.earth/gtfs-germany.zip'

unzip -o -j -q -d gtfs gtfs-germany.zip agency.txt
unzip -o -j -q -d gtfs gtfs-germany.zip stops.txt

echo 'done!'


echo_heading 'generating agency.txt from DELFI GTFS'

invalid_routes=$(qsv join --left \
	agency_id routes.txt \
	agency_id gtfs/agency.txt \
	| qsv search -s 'agency_id[1]' '^$')
nr_of_invalid_routes="$(echo -n $(echo "$invalid_routes" | tail -n +2 | wc -l))"
if [ $nr_of_invalid_routes -gt 0 ]; then
	1>&2 echo "there are $nr_of_invalid_routes routes.txt rows with invalid/unknown agency_id:"
	1>&2 echo "$invalid_routes"
	exit 1
fi

# keep all gtfs/agency.txt rows referenced in routes.txt
qsv join --left \
	agency_id routes.txt \
	agency_id gtfs/agency.txt \
	| qsv select "$(head -n 1 gtfs/agency.txt | tr -d '\r\n')" \
	| qsv dedup -s agency_id \
	>agency.txt

echo 'done!'



echo_heading 'generating stops.txt from DELFI GTFS'

invalid_stops=$(qsv join --left \
	location_id location_groups.txt \
	stop_id gtfs/stops.txt \
	| qsv search -s stop_id '^$')
nr_of_invalid_stops="$(echo -n $(echo "$invalid_stops" | tail -n +2 | wc -l))"
if [ $nr_of_invalid_stops -gt 0 ]; then
	1>&2 echo "there are $nr_of_invalid_stops location_groups.txt rows with invalid/unknown location_id/stop_id:"
	1>&2 echo "$invalid_stops"
	exit 1
fi

# keep all gtfs/stops.txt rows referenced in location_groups.txt
qsv join --left \
	location_id location_groups.txt \
	stop_id gtfs/stops.txt \
	| qsv select "$(head -n 1 gtfs/stops.txt | tr -d '\r\n')" \
	| qsv dedup -s stop_id \
	>stops.txt

echo 'done!'



# echo_heading 'validating GTFS feed'

# Google's GTFS Validator doesn't seem to have a Docker image.
# see https://github.com/google/transitfeed/wiki/FeedValidator
# The MoblityData GTFS Validator currently doesn't support GTFS-Flex v2.
# see https://github.com/MobilityData/gtfs-validator/issues/1067#issuecomment-990253322
# GTFSVTOR doesn't support GTFS-Flex v2.
# todo
# docker run -it --rm -v $PWD:/gtfs mfdz/gtfsvtor -o /gtfs/validation-results.html /gtfs