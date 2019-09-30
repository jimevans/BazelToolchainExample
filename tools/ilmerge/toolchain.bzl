def _merge_toolchain_impl(ctx):
    toolchain_info = platform_common.ToolchainInfo(
        merge_tool = ctx.files.merge_tool.path,
    )
    return [toolchain_info]

merge_toolchain = rule(
    implementation = _merge_toolchain_impl,
    attrs = {
        "merge_tool": attr.label(
            executable = True,
            allow_single_file = True,
            mandatory = True,
            cfg = "host",
        )
    },
)
