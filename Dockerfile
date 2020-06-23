# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
FROM centos:7.6.1810

RUN yum -y install \
        bzip2 bzip2-devel \
        gcc gcc-c++ gcc48-c++ \
        git \
        lz4-devel \
        make \
        snappy snappy-devel \
        which \
        zlib zlib-devel \
      && yum clean all \
      && rm -rf /var/cache/yum

RUN git clone https://github.com/gflags/gflags.git \
      && cd gflags \
      && git checkout v2.0 \
      && ./configure && make && make install \
      && cd .. \
      && rm -fr gflags

RUN curl -LSs -o zstd-1.1.3.tar.gz https://github.com/facebook/zstd/archive/v1.1.3.tar.gz \
      && tar zxvf zstd-1.1.3.tar.gz \
      && cd zstd-1.1.3 \
      && make && make install \
      && cd .. \
      && rm -fr zstd-1.1.3 zstd-1.1.3.tar.gz

RUN curl -LSs -o rocksdb-6.8.1.tar.gz https://github.com/facebook/rocksdb/archive/v6.8.1.tar.gz \
      && tar xzvf rocksdb-6.8.1.tar.gz \
      && cd rocksdb-6.8.1 \
      && make ldb \
      && mv ldb /usr/local/bin/ \
      && cd .. \
      && rm -fr rocksdb-6.8.1 rocksdb-6.8.1.tar.gz

ENV LD_LIBRARY_PATH /usr/local/lib
