const Encore = require('@symfony/webpack-encore');

Encore
    .setOutputPath('public/build/')
    .setPublicPath('/build')

    .addStyleEntry('css/app', './assets/styles/app.css')
    .addStyleEntry('header.scss', './assets/styles/header.scss')
    .addStyleEntry('index.scss', './assets/styles/index.scss')

    .enableSingleRuntimeChunk()


    .enableSassLoader()

    .cleanupOutputBeforeBuild()
    .enableSourceMaps(!Encore.isProduction())
    .enableVersioning(Encore.isProduction())

    .copyFiles({
        from: './assets/images',
        to: 'images/[path][name].[ext]',
    })
;

module.exports = Encore.getWebpackConfig();
