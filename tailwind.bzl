"tailwind for build binary and run"

load("@aspect_rules_js//js:defs.bzl", "js_binary", "js_run_binary")

def tailwind_runner(runner_name, css, cfg, out, data):
    csslocation = "$(execpath %s)" % css
    cfglocation = "$(execpath %s)" % cfg
    outlocation = "$(rootpath %s)" % out
    input_list = [
        css,
        cfg,
    ] + data
    input_args = [
        "-i",
        csslocation,
        "-c",
        cfglocation,
        "-o",
        outlocation,
    ]
    js_run_binary(
        name = runner_name,
        copy_srcs_to_bin = True,
        srcs = input_list,
        outs = [out],
        args = input_args,
        log_level = "debug",
        tool = "@rules_tailwind//:tailwind_gen",
    )
    pass
