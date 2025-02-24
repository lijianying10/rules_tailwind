"tailwind for build binary and run"

load("@aspect_rules_js//js:defs.bzl", "js_binary", "js_run_binary")

# def _tailwind_run_impl(ctx):
#     input_list = [
#         ctx.file.css,
#         ctx.file.cfg,
#     ]

#     for i in ctx.attr.data:
#         for f in i.files.to_list():
#             input_list.append(f)

#     input_args = [
#         "-i",
#         ctx.file.css.path,
#         "-c",
#         ctx.file.cfg.path,
#         "-o",
#         ctx.outputs.out.path,
#     ]

#     ctx.actions.run(
#         outputs = [ctx.outputs.out],
#         inputs = input_list,
#         arguments = input_args,
#         mnemonic = "tailwind",
#         executable = ctx.executable.runner,
#         progress_message = None,
#         use_default_shell_env = False,
#         execution_requirements = None,
#         input_manifests = None,
#     )
#     pass

# tailwind_run = rule(
#     implementation = _tailwind_run_impl,
#     attrs = {
#         "css": attr.label(
#             doc = "input css file for tailwind",
#             allow_single_file = [".css"],
#         ),
#         "cfg": attr.label(
#             doc = "tailwind config file",
#             allow_single_file = [".config.js"],
#         ),
#         "data": attr.label_list(
#             doc = "input the html need to be parse",
#             allow_files = [".html", ".js", ".css"]
#         ),
#         "out": attr.output(mandatory = True),
#         "runner": attr.label(
#             executable = True,
#             cfg = "exec",
#             allow_files = True,
#             mandatory = True,
#         ),
#     },
# )

def tailwind_runner(runner_name, css, cfg, out, data):
    print("debug", data)
    csslocation = "$(execpath %s)" % css
    cfglocation = "$(execpath %s)" % cfg
    outlocation = "$(rootpath %s)" % out
    input_list = [
        css,
        cfg,
    ] + data
    input_args = [
        csslocation,
        cfglocation,
        outlocation,
    ]
    js_run_binary(
        name = runner_name,
        copy_srcs_to_bin = True,
        srcs = input_list,
        outs = [out],
        args = input_args,
        # Request that the rules_js launcher prints extra information
        log_level = "debug",
        tool = "//:tailwind_gen",
        # Uncomment the setting below to see debug output even on a
        # successful run of the build action.
        # silent_on_success = False,
    )
    pass
