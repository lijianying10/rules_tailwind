load("@npm//:defs.bzl", "npm_link_all_packages")
load("@aspect_rules_js//js:defs.bzl", "js_library", "js_binary")

npm_link_all_packages(name = "node_modules")

js_binary(
    name = "tailwind_gen",
    data = [
        "@npm//node_modules/@tailwindcss/aspect-ratio",
        "@npm//node_modules/@tailwindcss/container-queries",
        "@npm//node_modules/@tailwindcss/forms",
        "@npm//node_modules/@tailwindcss/line-clamp",
        "@npm//node_modules/@tailwindcss/typography",
        "@npm//node_modules/autoprefixer",
        "@npm//node_modules/tailwindcss",
        "@npm//node_modules/postcss",
    ],
    entry_point = "@rules_tailwind//:cli.js",
    visibility = ["//visibility:public"],
)
exports_files(["cli.js","package-lock.json","package.json"])
