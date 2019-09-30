load(":toolchain.bzl", "merge_toolchain")

toolchain_type(name = "toolchain_type")

merge_toolchain(
    name = "ilmerger",
    merge_tool = ":ilmerge.exe",
)

toolchain(
    name = "ilmerge_toolchain",
    exec_compatible_with = [
        "@platforms//os:windows",
        "@platforms//cpu:x86_64",
    ],
    target_compatible_with = [
        "@platforms//os:windows",
        "@platforms//cpu:x86_64",
    ],
    toolchain = ":ilmerger",
    toolchain_type = ":toolchain_type",
)
