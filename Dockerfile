FROM debian:sid

RUN apt-get update && apt-get upgrade -y && apt-get install -y cmake clang bison flex xz-utils libfuse-dev libudev-dev pkg-config libc6-dev-i386 linux-headers-amd64 libcap2-bin git libgcc-5-dev libcairo2-dev libgl1-mesa-dev libtiff5-dev libfreetype6-dev libfreetype6-dev git && apt-get clean
RUN git config --global http.sslVerify false && (git clone --recursive https://github.com/darlinghq/darling.git || true) && cd /darling && git submodule foreach git reset --hard && mkdir -p /darling/build && cd /darling/build && cmake ..

#WORKDIR /darling/src/external/WTF/
#RUN git checkout 3618227350ff92731eee06d2ac7eacf032baec88
#WORKDIR /darling
#RUN git submodule foreach git reset --hard

#RUN mkdir -p /darling/build
WORKDIR /darling/build

#RUN cmake ..

RUN make
#RUN make install DESTDIR=/raw_output

VOLUME /output

CMD bash 
