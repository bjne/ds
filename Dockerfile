FROM ubuntu:14.04

RUN	apt-get update && \
	apt-get -y upgrade && \
	apt-get -y install \
		build-essential \
		cmake \
		exuberant-ctags \
		git \
		libboost-dev \
		libboost-program-options-dev \
		libboost-test-dev \
		libboost-thread-dev \
		libbz2-dev \
                libdigest-hmac-perl \
		libdigest-sha-perl \
		libevent-dev \
		libextutils-parsexs-perl \
		liblzo2-dev \
		liblz4-dev \
		libpcre3-dev \
		libsnappy-dev \
		libssl-dev \
		libxml2-dev \
		libxml-parser-perl \
		libz-dev \
		perl \
		make \
		vim

WORKDIR	/usr/src

RUN	git clone http://github.com/dataseries/Lintel.git
RUN	git clone http://github.com/dataseries/DataSeries.git
RUN	mkdir -p build/Lintel build/DataSeries
RUN	sed -i -e '/_UNUSED_/,+1d' Lintel/src/perl/xsubpp-cleanup
RUN	cd build/Lintel && \
	cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr ../../Lintel && \
	make -j10 && \
	make install
RUN	cd build/DataSeries && \
	cmake	-DCMAKE_INSTALL_PREFIX:PATH=/usr \
		-DWITH_POD2MAN:BOOL=OFF ../../DataSeries && \
	make -j10 && \
	make install

ENV HOME /root

WORKDIR /root

CMD ["bash"]
