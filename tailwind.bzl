"tailwind for build binary and run"

load("@build_bazel_rules_nodejs//:index.bzl", "nodejs_binary")

def _tailwind_run_impl(ctx):
    input_list = [
        ctx.file.css,
        ctx.file.cfg,
    ]

    for i in ctx.attr.data:
        for f in i.files.to_list():
            input_list.append(f)

    input_args = [
        "-i",
        ctx.file.css.path,
        "-c",
        ctx.file.cfg.path,
        "-o",
        ctx.outputs.out.path,
    ]

    ctx.actions.run(
        outputs = [ctx.outputs.out],
        inputs = input_list,
        arguments = input_args,
        mnemonic = "tailwind",
        executable = ctx.executable.runner,
        progress_message = None,
        use_default_shell_env = False,
        execution_requirements = None,
        input_manifests = None,
    )
    pass

tailwind_run = rule(
    implementation = _tailwind_run_impl,
    attrs = {
        "css": attr.label(
            doc = "input css file for tailwind",
            allow_single_file = [".css"],
        ),
        "cfg": attr.label(
            doc = "tailwind config file",
            allow_single_file = [".config.js"],
        ),
        "data": attr.label_list(
            doc = "input the html need to be parse",
            allow_files = [".html", ".js"]
        ),
        "out": attr.output(mandatory = True),
        "runner": attr.label(
            executable = True,
            cfg = "exec",
            allow_files = True,
            mandatory = True,
        ),
    },
)

def tailwind_runner(runner_name, css, cfg, out, data):
    input_list = [
        css,
        cfg,
        "@npm//@tailwindcss/aspect-ratio",
        "@npm//@tailwindcss/container-queries",
        "@npm//@tailwindcss/forms",
        "@npm//@tailwindcss/line-clamp",
        "@npm//@tailwindcss/typography",
        "@npm//autoprefixer",
        "@npm//tailwindcss",
    ] + data
    input_args = [
        "-i",
        css,
        "-c",
        cfg,
        "-o",
        out,
    ]
    nodejs_binary(
        name = runner_name,
        data = input_list,
        entry_point = "@rules_tailwind//:cli.js",
        templated_args = input_args,
    )
    pass
