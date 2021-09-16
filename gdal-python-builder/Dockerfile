# vim: set syntax=dockerfile:

FROM osgeo/gdal:alpine-normal-3.1.0

RUN apk update && \
  apk add gcc g++ musl-dev python3-dev openssl openssl-dev curl curl-dev geos geos-dev py3-numpy py3-numpy-dev
RUN pip3 install --upgrade pip && \
  pip3 install --prefix=/usr/local "pycurl>=7.43.0.6,<7.43.1" "pyproj==2.2.0" "pandas==0.23.0" "geopandas==0.8.1" "tzlocal==3.0"

