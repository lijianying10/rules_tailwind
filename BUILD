load("@npm//:defs.bzl", "npm_link_all_packages")
load("@aspect_rules_js//js:defs.bzl", "js_library", "js_binary")

npm_link_all_packages(name = "node_modules")

js_binary(
    name = "tailwind_gen",
    data = [
        "@rules_tailwind//:node_modules/@tailwindcss/aspect-ratio",
        "@rules_tailwind//:node_modules/@tailwindcss/container-queries",
        "@rules_tailwind//:node_modules/@tailwindcss/forms",
        "@rules_tailwind//:node_modules/@tailwindcss/line-clamp",
        "@rules_tailwind//:node_modules/@tailwindcss/typography",
        "@rules_tailwind//:node_modules/autoprefixer",
        "@rules_tailwind//:node_modules/tailwindcss",
        "@rules_tailwind//:node_modules/postcss",
    ],
    entry_point = "@rules_tailwind//:cli.js",
    visibility = ["//visibility:public"],
)
exports_files(["cli.js","package-lock.json","package.json"])
