-- xmake macro package -a x86_64 -o ../000_packages -p mingw
add_packagedirs("../000_packages")

set_project("006_bitcoin") 
set_version("1.0.0", {build = "%Y%m%d%H%M"})
set_xmakever("2.2.5")
set_warnings("all", "error")

set_languages("gnu99", "cxx11")

add_cxflags("-fno-strict-aliasing", "-Wno-error=deprecated-declarations", 
    "-Wno-error=unused-parameter", "-Wno-error=implicit-fallthrough",
    "-Wno-error=sign-compare", "-Wno-error=format", "-Wno-unused-parameter")
add_cxflags("-O2", "-Wall", "-Wextra", "-fPIC")

add_defines("LUA_COMPAT_5_2=1")
set_strip("all")

target("bitcoin_core")  
    set_kind("shared")
    add_packages("boost", "leveldb")
    add_links("boost_date_time", "boost_filesystem", "leveldb")

    add_defines("BITCOINSHAREDLIB=1")
    add_defines("HAVE_SYS_SELECT_H=1", "HAVE_GMTIME_R=1", "HAVE_DECL_STRNLEN=1")
    add_defines("HAVE___INT128", "USE_FIELD_5X52=1", "USE_NUM_NONE=1", "USE_FIELD_INV_BUILTIN=1", "USE_SCALAR_INV_BUILTIN=1", "USE_SCALAR_4X64=1") 
    if is_plat("mingw") then 
        add_defines("WIN32=1") 
        add_cxflags("-Wno-error=return-type")
        add_links("ws2_32")
    elseif is_plat("linux") then 
        add_defines("LINUX=1") 
    end 

    add_includedirs("src", "src/univalue/lib", "src/univalue/include", "src/secp256k1/src",
        "src/secp256k1","src/secp256k1/include","src/secp256k1/contrib", "src/crypto/ctaes")
    add_cxflags("-Wno-error=unused-function", "-Wno-error=nonnull-compare")
    
    add_files(
        "src/secp256k1/src/secp256k1.c"
        ,"src/secp256k1/src/gen_context.c"
        ,"src/secp256k1/contrib/lax_der_privatekey_parsing.c"
        ,"src/secp256k1/contrib/lax_der_parsing.c" 
        ) 

    -- add_files(
    --     "src/crypto/siphash.cpp" 
    --     ,"src/crypto/aes.cpp" 
    --     ,"src/crypto/chacha_poly_aead.cpp" 
    --     ,"src/crypto/chacha20.cpp" 
    --     ,"src/crypto/hkdf_sha256_32.cpp" 
    --     ,"src/crypto/hmac_sha256.cpp" 
    --     ,"src/crypto/hmac_sha512.cpp" 
    --     ,"src/crypto/poly1305.cpp" 
    --     ,"src/crypto/ripemd160.cpp" 
    --     ,"src/crypto/sha1.cpp" 
    --     ,"src/crypto/sha256.cpp" 
    --     ,"src/crypto/sha256_avx2.cpp" 
    --     ,"src/crypto/sha256_shani.cpp" 
    --     ,"src/crypto/sha256_sse4.cpp" 
    --     ,"src/crypto/sha256_sse41.cpp" 
    --     ,"src/crypto/sha512.cpp" 
    --     --,"src/crypto/ctaes/ctaes.c" 
    --     )

    -- add_files(
    --     "src/compat/strnlen.cpp"
    --     ,"src/compat/glibc_compat.cpp"
    --     ,"src/compat/glibc_sanity.cpp"
    --     ,"src/compat/glibc_sanity_fdelt.cpp"
    --     ,"src/compat/glibcxx_sanity.cpp"
    --     ,"src/compat/stdin.cpp"
    --     ) 

    add_files(
        "src/support/lockedpool.cpp"
        ,"src/support/cleanse.cpp" 
        )     

    add_files(
        "src/util/asmap.cpp" 
        --,"src/util/url.cpp" 
        ,"src/util/time.cpp" 
        ,"src/util/threadnames.cpp" 
        ,"src/util/system.cpp" 
        ,"src/util/string.cpp" 
        ,"src/util/strencodings.cpp" 
        ,"src/util/spanparsing.cpp" 
        ,"src/util/settings.cpp" 
        ,"src/util/rbf.cpp" 
        ,"src/util/moneystr.cpp" 
        ,"src/util/message.cpp" 
        ,"src/util/fees.cpp" 
        ,"src/util/error.cpp" 
        ,"src/util/bytevectorhash.cpp" 
        ,"src/util/bip32.cpp" 
        )

    add_files(
        "src/primitives/*.cpp"
        ,"src/script/*.cpp"
        ,"src/univalue/lib/*.cpp"
        ,"src/policy/*.cpp"
        ,"src/consensus/*.cpp"
        ,"src/crypto/*.cpp" 
        ,"src/rpc/*.cpp" 
        ,"src/node/*.cpp"
        ,"src/interfaces/*.cpp"
        ,"src/index/*.cpp"
        ,"src/wallet/*.cpp"
        ,"src/*.cpp"
        ) 


target("postprocess")
    set_kind("phony")
    add_deps("bitcoin_core") 
    after_package(function (target)

    end)     
