

##usage：

### server

第一次啟動會依照指定的環境變數(POSTGRES_PASSWORD / POSTGRES_USER / POSTGRES_DB)設定 postGIS
```postgis:
  image: herryhou/postgisosm
  hostname: postgis
  environment:
    POSTGRES_PASSWORD: "yours@secret"
    POSTGRES_USER: "postgres"
    POSTGRES_DB: "gis"
  ports:
    - "5432:5432"
```


### OSM importer
環境變數裡面指定要導入的 osm pdb 檔案名
```
osm:
  image: herryhou/postgisosm
  hostname: osm
  environment:
    #OSM_PBF: "/src/taipei.osm.pbf"
    OSM_PBF: "/src/taichung_taiwan.osm.pbf"
    PGUSER: "postgres"
    PGPASSWORD: "yours@secret"
  links:
    - postgis:postgis
  volumes:
    - /vagrant/osmdata:/src
  command: "/importOSM.sh"
```
