const process = require("process");
const fs = require("fs");
const postcss = require('postcss');
const tailwindcssPostCSS = require('@tailwindcss/postcss');
const path = require('path');
// console.log(process.env)

// 解析命令行参数
const [inputFile, configFile, outputFile] = process.argv.slice(2);

// 参数验证
if (!inputFile || !configFile || !outputFile) {
    console.error('使用方法: node cli.js <输入CSS文件> <Tailwind配置文件> <输出CSS文件>');
    process.exit(1);
}

// 确保文件路径是绝对路径
const resolveFile = (file) => path.resolve(process.cwd(), file);

const inputPath = resolveFile(inputFile);
const configPath = resolveFile(configFile);
const outputPath = resolveFile(outputFile);

// 验证文件是否存在
if (!fs.existsSync(inputPath)) {
    console.error(`输入文件不存在: ${inputPath}`);
    process.exit(1);
}

if (!fs.existsSync(configPath)) {
    console.error(`配置文件不存在: ${configPath}`);
    process.exit(1);
}

// 确保输出目录存在
const outputDir = path.dirname(outputPath);
if (!fs.existsSync(outputDir)) {
    fs.mkdirSync(outputDir, { recursive: true });
}

async function compileTailwindCSS() {
    try {
        // 读取源CSS文件
        const css = fs.readFileSync(inputPath, 'utf8');

        // 动态导入配置文件
        const tailwindConfig = require(configPath);

        // 使用PostCSS处理CSS
        const result = await postcss([
            tailwindcssPostCSS(tailwindConfig)
        ]).process(css, {
            from: inputPath,
            to: outputPath
        });

        // 写入编译后的CSS
        fs.writeFileSync(outputPath, result.css);
        
        if (result.map) {
            fs.writeFileSync(`${outputPath}.map`, result.map.toString());
        }

        console.log('Tailwind CSS 编译成功！');
        console.log(`输出文件: ${outputPath}`);

    } catch (error) {
        console.error('编译失败：', error.message);
        process.exit(1);
    }
}

// 立即执行
compileTailwindCSS();