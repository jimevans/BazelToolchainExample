load(":merge-assemblies.bzl", "merged_assembly")

merged_assembly(
    name = "example",
    out = "output.dll",
    src_assembly = "mainsource.dll",
    deps = [
        "mergesource.dll",
    ],
)
