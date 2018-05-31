function download() {
    wget --continue "$1"
}

function extract() {
    tar xvf "$1"
}

function makej() {
    make -j $(nproc)
}

function download_make_install() {
    name="$(basename $1)"
    download "$1"
    extract $name
    if [ -z "$2" ]; then
        pushd ${name%%.tar*}
    else
        pushd $2
    fi

    if [ -x ./Configure ]; then
        ./Configure --prefix=$PREFIX $3
    else
        ./configure --prefix=$PREFIX $3
    fi
    makej
    make install
    popd
}

function download_make_install_local() {
  if [ -f "$4" ]; then
    echo "SKIP download_make_install_local $1 $2 $3: $4 exists"
  else
    echo "download_make_install_local: $4 MISSING"
    name="$(basename $1)"
    download "$1"
    extract $name
    if [ -z "$2" ]; then
        pushd ${name%%.tar*}
    else
        pushd $2
    fi

    if [ -x ./Configure ]; then
        ./Configure --prefix=$LOCAL_PREFIX $3
    else
        ./configure --prefix=$LOCAL_PREFIX $3
    fi
    makej
    make install
    popd
  fi
}


function install_gcc_deps() {
  download_make_install_local https://internal-dependencies.mapd.com/thirdparty/gmp-6.1.2.tar.xz "" "--enable-fat" $LOCAL_PREFIX/lib/libTODO
  download_make_install_local https://internal-dependencies.mapd.com/thirdparty/mpfr-3.1.5.tar.xz "" "--with-gmp=$LOCAL_PREFIX" $LOCAL_PREFIX/lib/libTODO
  download_make_install_local ftp://ftp.gnu.org/gnu/mpc/mpc-1.0.3.tar.gz "" "--with-gmp=$LOCAL_PREFIX" $LOCAL_PREFIX/lib/libTODO
}

function install_gcc() {
  if [ -f "$2" ]; then
    echo "SKIP install_gcc: $2 exists"
  else  
    $SYSTEM_INSTALL_COMMAND gcc-c++ gcc
    #install_gcc_deps
    download ftp://ftp.gnu.org/gnu/gcc/gcc-$GCC_VERSION/gcc-$GCC_VERSION.tar.xz
    extract gcc-$GCC_VERSION.tar.xz
    pushd gcc-$GCC_VERSION
    export CPPFLAGS="-I$1/include"
    ./configure \
      --prefix=$1 \
      --disable-multilib \
      --enable-bootstrap \
      --enable-shared \
      --enable-threads=posix \
      --enable-checking=release \
      --with-system-zlib \
      --enable-__cxa_atexit \
      --disable-libunwind-exceptions \
      --enable-gnu-unique-object \
      --enable-languages=c,c++ \
      --with-tune=generic \
      #--with-gmp=$PREFIX \
      #--with-mpc=$PREFIX \
      #--with-mpfr=$PREFIX #replace '--with-tune=generic' with '--with-tune=power8' for POWER8
    makej
    make install
    popd
    $SUDO yum remove -y gcc-c++ gcc # to make sure that gcc-5 is used   
  fi
}

function install_awscpp() {
  if [ -f "$2" ]; then
    echo "SKIP install_awscpp: $2 exists"
  else
    echo "$1 $2 missing"
    # default c++ standard support
    CPP_STANDARD=14
    # check c++17 support
    GNU_VERSION1=`g++ --version|head -n1|awk '{print $4}'|cut -d'.' -f1`
    if [ "$GNU_VERSION1" = "7" ]; then
        CPP_STANDARD=17
    fi
    rm -rf aws-sdk-cpp-${AWSCPP_VERSION}
    download https://github.com/aws/aws-sdk-cpp/archive/${AWSCPP_VERSION}.tar.gz
    tar xvfz ${AWSCPP_VERSION}.tar.gz
    pushd aws-sdk-cpp-${AWSCPP_VERSION}
    mkdir build
    cd build
    $CMAKE \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=$1 \
        -DBUILD_ONLY="s3" \
        -DBUILD_SHARED_LIBS=0 \
        -DCUSTOM_MEMORY_MANAGEMENT=0 \
        -DCPP_STANDARD=$CPP_STANDARD \
        ..
    make

    # sudo is needed on osx
    os=`uname`
    if [ "$os" = "Darwin" ]; then
        sudo make install
    else 
        make install
    fi

    popd
  fi
}

function install_thrift() {
  if [ -x "$2" ]; then
    echo "SKIP install_thrift: $2 exists"
  else
    echo "$1 $2 MISSING"
    download http://apache.claz.org/thrift/$THRIFT_VERSION/thrift-$THRIFT_VERSION.tar.gz
    extract thrift-$THRIFT_VERSION.tar.gz
    pushd thrift-$THRIFT_VERSION
    patch -p1 < $RECIPE_DIR/thrift-3821-tmemorybuffer-overflow-check.patch
    patch -p1 < $RECIPE_DIR/thrift-3821-tmemorybuffer-overflow-test.patch
    CFLAGS="-fPIC" CXXFLAGS="-fPIC" JAVA_PREFIX=$PREFIX/lib ./configure \
      --prefix=$1 \
      --with-lua=no \
      --with-python=no \
      --with-php=no \
      --with-ruby=no \
      --with-qt4=no \
      --with-qt5=no \
      #--with-boost-libdir=$BOOST_PREFIX/lib
    makej
    make install
    popd
  fi
}

function install_double_conversion() {
  if [ -f "$2" ]; then
    echo "SKIP install_double_conversion: $2 exists"
  else
    download https://github.com/google/double-conversion/archive/4abe3267170fa52f39460460456990dbae803f4d.tar.gz
    extract 4abe3267170fa52f39460460456990dbae803f4d.tar.gz
    mv double-conversion-4abe3267170fa52f39460460456990dbae803f4d google-double-conversion-4abe326
    mkdir -p google-double-conversion-4abe326/build
    pushd google-double-conversion-4abe326/build
    $CMAKE -DCMAKE_CXX_FLAGS="-fPIC" -DCMAKE_BUILD_TYPE=Release \
         -DCMAKE_INSTALL_PREFIX=$1 ..
    makej
    make install
    popd
  fi  
}

function install_gflags() {
  if [ -f "$2" ]; then
    echo "SKIP install_gflags: $2 exists"
  else
    download https://github.com/gflags/gflags/archive/v$GFLAGS_VERSION.tar.gz
    extract v$GFLAGS_VERSION.tar.gz
    mkdir -p gflags-$GFLAGS_VERSION/build
    pushd gflags-$GFLAGS_VERSION/build
    $CMAKE -DCMAKE_CXX_FLAGS="-fPIC" -DCMAKE_BUILD_TYPE=Release \
           -DCMAKE_INSTALL_PREFIX=$1 ..
    makej
    make install
    popd
  fi
}

function install_folly() {
  if [ -f "$2" ]; then
    echo "SKIP install_folly: $2 exists"
  else
    install_double_conversion $1 $1/include/double-conversion/double-conversion.h
    install_gflags $1 $1/include/gflags/gflags.h
    CXXFLAGS="-fPIC" download_make_install_local https://github.com/google/glog/archive/v$GLOG_VERSION.tar.gz \
        glog-$GLOG_VERSION "--enable-shared=no" $1/include/glog/logging.h
    # --build=powerpc64le-unknown-linux-gnu"
    download_make_install_local https://github.com/libevent/libevent/releases/download/release-$LIBEVENT_VERSION-stable/libevent-$LIBEVENT_VERSION-stable.tar.gz \
        "" "" $1/include/event2/event.h

    download https://github.com/facebook/folly/archive/v$FOLLY_VERSION.tar.gz
    extract v$FOLLY_VERSION.tar.gz
    pushd folly-$FOLLY_VERSION/folly
    autoreconf -ivf
    CXXFLAGS="-fPIC -pthread" ./configure --prefix=$1 \
        --enable-shared=no \
        --with-boost=$BOOST_PREFIX \
        --with-boost-libdir=$BOOST_LIBDIR
    makej
    make install
    popd

  fi
}


function install_arrow() {
  if [ -f "$2" ]; then
    echo "SKIP install_arrow: $2 exists"
  else
    download https://github.com/apache/arrow/archive/apache-arrow-$ARROW_VERSION.tar.gz
    extract apache-arrow-$ARROW_VERSION.tar.gz
    mkdir -p arrow-apache-arrow-$ARROW_VERSION/cpp/build
    pushd arrow-apache-arrow-$ARROW_VERSION/cpp/build
    $CMAKE \
      -DCMAKE_BUILD_TYPE=Release \
      -DARROW_BUILD_SHARED=ON \
      -DARROW_BUILD_STATIC=ON \
      -DARROW_BUILD_TESTS=OFF \
      -DARROW_BUILD_BENCHMARKS=OFF \
      -DARROW_WITH_BROTLI=OFF \
      -DARROW_WITH_ZLIB=OFF \
      -DARROW_WITH_LZ4=OFF \
      -DARROW_WITH_SNAPPY=OFF \
      -DARROW_WITH_ZSTD=OFF \
      -DCMAKE_INSTALL_PREFIX=$1 \
      -DARROW_BOOST_USE_SHARED=${ARROW_BOOST_USE_SHARED:="ON"} \
      -DBOOST_LIBRARYDIR=$BOOST_LIBDIR \
      -DBOOST_INCLUDEDIR=$BOOST_PREFIX/include \
      -DBoost_NO_SYSTEM_PATHS=ON \
      ..
    make -j $(nproc)
    make install
    popd
  fi
}
