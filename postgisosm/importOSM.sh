#!/bin/sh

set -e
psql -U postgres -h $POSTGIS_PORT_5432_TCP_ADDR -d gis -f postgis-vt-util.sql
osm2pgsql --slim -C 1600 -U postgres -H $POSTGIS_PORT_5432_TCP_ADDR -d gis $OSM_PBF