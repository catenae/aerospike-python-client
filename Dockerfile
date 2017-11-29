# Aerospike Python Client (Alpine Linux, Miniconda 3)
# Copyright (C) 2017 Rodrigo Martínez <dev@brunneis.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

FROM catenae/alpine-miniconda3:4.3

ENV AEROSPIKE_C_VERSION=4.1.8 \
AEROSPIKE_C_BASE_URL=https://github.com/aerospike/aerospike-client-c \
AEROSPIKE_PYTHON_VERSION=2.2.3 \
AEROSPIKE_C_HOME=/aerospike-client-c \
DOWNLOAD_C_CLIENT=0

RUN \
    apk update && apk upgrade \
    && apk add \
        bash \
        build-base \
        git \
        linux-headers \
        openssl-dev \
    && git clone --recursive --branch $AEROSPIKE_C_VERSION $AEROSPIKE_C_BASE_URL \
    && cd aerospike-client-c \
    && make \
    && pip install --upgrade pip \
    && pip install aerospike==$AEROSPIKE_PYTHON_VERSION \
    && apk del --purge \
        bash \
        build-base \
        git \
        linux-headers \
        openssl-dev \
    && rm -rf \
        /root/.cache/pip \
        /aerospike-client-c \
        /var/cache/apk/* \
    && find / -type d -name __pycache__ -exec rm -r {} \+

