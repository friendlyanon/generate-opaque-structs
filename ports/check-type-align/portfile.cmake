set(VCPKG_BUILD_TYPE release)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO friendlyanon/check-type-align
    REF 8d8d54827a8da81c93adfe3f132cd78872c1fd36
    SHA512 c5ee6829e33cdf6414dd56fcc38780bad293a54b1e97cf725747f2c4352d83b8c0d29283a4bf0054efc5e9c7d94b00b7698a2732242af9b0f6a65e6f0155ad5e
    HEAD_REF master
)

set(name CheckTypeAlign)

vcpkg_cmake_configure(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_cmake_install()

# No license, write a dummy
file(WRITE "${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright" "")
