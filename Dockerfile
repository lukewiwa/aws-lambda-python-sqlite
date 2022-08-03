ARG PYTHON_VERSION=3.9
FROM public.ecr.aws/lambda/python:${PYTHON_VERSION} as build

WORKDIR /sqlite/

RUN yum groupinstall "Development Tools" -y && \
    yum install -y tcl

RUN curl -sSL https://www.sqlite.org/src/tarball/sqlite.tar.gz?r=release \
        --output ./sqlite.tar.gz && \
    tar xzf sqlite.tar.gz

WORKDIR /sqlite/bld
RUN sh ../sqlite/configure && make


FROM public.ecr.aws/lambda/python:${PYTHON_VERSION}

COPY --from=build sqlite/bld/.libs/libsqlite3.so /var/lang/lib/libsqlite3.so
COPY --from=build sqlite/bld/.libs/libsqlite3.so.0 /var/lang/lib/libsqlite3.so.0
COPY --from=build sqlite/bld/.libs/libsqlite3.so.0.8.6 /var/lang/lib/libsqlite3.so.0.8.6
