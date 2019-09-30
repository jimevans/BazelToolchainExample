def _merged_assembly_impl(ctx):
    name = ctx.label.name

    deps = ctx.attr.deps
    result = ctx.outputs.out

    args = [
        "-v4",
        "-xmldocs",
        "-internalize",
    ]

    if ctx.attr.keyfile != None:
        key_path = ctx.expand_location(ctx.attr.keyfile.files.to_list()[0].path)
        args.append("-keyfile:{}".format(key_path))

    args.append("-out={}".format(ctx.outputs.out.path))
    args.append(ctx.attr.src_assembly.files.to_list()[0].path)
    for dep in ctx.files.deps:
        args.append(ctx.expand_location(dep.path))

    ctx.actions.run(
        executable = ctx.toolchain.merge_tool.path,
        arguments = args,
        inputs = ctx.attr.src_assembly.files,
        outputs = [ctx.outputs.out]
    )

    runfiles = ctx.runfiles(
        files = [ctx.outputs.out],
    )

    for dep in ctx.files.deps:
        runfiles = runfiles.merge(dep[DefaultInfo].default_runfiles)

    return [
        DefaultInfo(
            runfiles = runfiles,
        ),
    ]

merged_assembly = rule(
    implementation = _merged_assembly_impl,
    attrs = {
        "src_assembly": attr.label(),
        "deps": attr.label_list(),
        "out": attr.output(mandatory = True),
        "keyfile": attr.label(allow_single_file = True),
    },
    toolchains = ["//tools/ilmerge:ilmerge_toolchain"],
)
