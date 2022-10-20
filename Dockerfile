ARG PYTHON_VERSION=3.9
FROM public.ecr.aws/lambda/python:${PYTHON_VERSION} as build

RUN yum groupinstall -y "Development Tools" && \
    yum install -y tcl

WORKDIR /
RUN git clone --depth 1 --branch master https://github.com/coleifer/pysqlite3.git

RUN curl -sSL https://www.sqlite.org/src/tarball/sqlite.tar.gz?r=release \
    --output sqlite.tar.gz
RUN tar xzf sqlite.tar.gz
WORKDIR /sqlite
RUN  ./configure && make sqlite3.c

RUN cp /sqlite/sqlite3.[ch] /pysqlite3/
WORKDIR /pysqlite3
RUN python setup.py build_static build


FROM public.ecr.aws/lambda/python:${PYTHON_VERSION}
ARG PYTHON_VERSION

COPY --from=build /pysqlite3/build/lib.linux-*/pysqlite3/_sqlite3.*.so /var/lang/lib/python${PYTHON_VERSION}/lib-dynload/
