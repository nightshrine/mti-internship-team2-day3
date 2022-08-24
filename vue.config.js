const isOnCloud9 = process.env.C9_PID !== undefined;

const devServerConfig = {
    disableHostCheck: true
}
if (isOnCloud9) {
    devServerConfig.public = `https://${process.env.C9_PID}.vfs.cloud9.ap-northeast-1.amazonaws.com`;
}

module.exports = {
    publicPath: "./",
    "devServer": devServerConfig
}