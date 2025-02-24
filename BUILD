load("@npm//:defs.bzl", "npm_link_all_packages")
load("@aspect_rules_js//js:defs.bzl", "js_library", "js_binary")

# js_library(
#     name = "libcli",
#     srcs = [
#         "cli.js",
#     ],
#      visibility = ["//visibility:public"],
# )

npm_link_all_packages(name = "node_modules")

js_binary(
    name = "tailwind_gen",
    data = [
        "//:node_modules/@tailwindcss/aspect-ratio",
        "//:node_modules/@tailwindcss/container-queries",
        "//:node_modules/@tailwindcss/forms",
        "//:node_modules/@tailwindcss/line-clamp",
        "//:node_modules/@tailwindcss/typography",
        "//:node_modules/autoprefixer",
        "//:node_modules/tailwindcss",
        "//:node_modules/postcss",
    ],
    entry_point = "@rules_tailwind//:cli.js",
    # fixed_args = input_args,
    visibility = ["//visibility:public"],
)
exports_files(["cli.js","package-lock.json","package.json"])
